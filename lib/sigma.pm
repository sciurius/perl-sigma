#! perl

package sigma;

use warnings;
use strict;

our $VERSION = '0.02';

=head1 NAME

sigma - Basic signatures and oo typing saver

=head1 ABSTRACT

My personal implementation of basic subroutine and method signatures,
using source filtering.

=head1 SYNOPSIS

The following transformations are implemented:

    sub foo ($x, $y) {
    sub foo {
        my ($x, $y) = @_;

    sub foo ($x, $y) :method {
    sub foo :method {
        my ($self, $x, $y) = @_;

    method foo ($x, $y) {
    sub foo :method {
        my ($self, $x, $y) = @_;

Also:

    $.foo  ->  $self->{foo}
    @.foo  ->  @{ $self->{foo} }
    %.foo  ->  %{ $self->{foo} }

It saves me a lot of typing.

=cut

use Filter::Simple;

my $debug = 0;

# This is needed otherwise the patterns in the sub will not compile.
my $self;

# Due to a bug in the quotelike extraction of Text::Balanced we cannot
# use code_no_comments...
FILTER_ONLY executable_no_comments => \&code_no_comments;

sub code_no_comments {

    # sub foo (xxx) { -> sub foo { my (xxx) = @_;
    s{ ^ (\s*) sub (\s+) ([[:alpha:]]\w*) (\s*) \( (\s*[\$\@\%]\w+.*?) \) (\s*) \{ (\s*) }
     {${1}sub${2}${3}${4}${6}\{ my (${5}) = \@_;${7}}gmsx;

    # sub foo (xxx) :method { -> sub foo :method { my ($self,xxx) = @_;
    s{ ^ (\s*) sub (\s+) ([[:alpha:]]\w*) (\s*) \( (\s*[\$\@\%]\w+.*?) \) (\s*:method\s*) \{ (\s*) }
     {${1}sub${2}${3}${4}${6}\{ my (\$self, ${5}) = \@_;${7}}gmsx;

    # method foo (xxx) { -> sub foo :method { my ($self,xxx) = @_;
    s{ ^ (\s*) method (\s+) ([[:alpha:]]\w*) (\s*) \( (\s*[\$\@\%]\w+.*?) \) (\s*) \{ (\s*) }
     {${1}sub${2}${3}${4}:method${6}\{ my (\$self, ${5}) = \@_;${7}}gsmx;

    # method foo { -> sub foo :method { my ($self) = @_;
    s{ ^ (\s*) method (\s+) ([[:alpha:]]\w*) (\s*) \{ (\s*) }
     {${1}sub${2}${3}:method${4}\{ my (\$self) = \@_;${5}}gsmx;

    s{ \$\.([[:alpha:]_]\w*) }{\$self->\{$1\}}gx;
    s{([@%])\.([[:alpha:]]\w*)}[$1\{ \$self->\{$2\} \}]g;
    s{ (^|\s)\.([[:alpha:]][\w:]*)\( }{$1\$self->$2(}gx;
    s{ (^|\s)\.([[:alpha:]][\w:]*)->\( }{$1\$self->\{$2\}->(}gx;

    warn($_) if $debug;
}

=head1 AUTHOR

Johan Vromans, C<< <JV at cpan.org> >>

=head1 SUPPORT AND DOCUMENTATION

Development of this module takes place on GitHub:
https://github.com/sciurius/perl-sigma

You can find documentation for this module with the perldoc command.

    perldoc sigma

Please report any bugs or feature requests using the issue tracker on
GitHub.

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2021 Johan Vromans, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

# When invoked standalone, it acts as a filter rewriting input to output.
#
# Note that in this case # comment lines are skipped but anything else
# is processed.

sub filter {
    my $line = "";

    my $flush = sub {
	local $_ = $line;
	code_no_comments();
	print $_;
	$line = "";
    };

    while ( <STDIN> ) {
	if ( /^\s+#/ ) {
	    $flush->() if $line ne "";
	    print;
	    next;
	}
	$line .= $_;
    }
    $flush->() if $line ne "";
}

filter unless caller;

1; # End of sigma

