package signatures;

use warnings;
use strict;

our $VERSION = '0.01';

=head1 NAME

signatures - Basic signatures

=head1 SYNOPSIS

My personal implementation of basic subroutine and method signatures,
using source filtering.

The following transformations are implemented:

    sub foo ($x, $y) {
    sub foo {
        my ($x, $y) = @_;

    sub foo ($x, $y) :method {
    sub foo :method {
        my ($self, $x, $y) = @_;

    sub method ($x, $y) {
    sub foo :method {
        my ($self, $x, $y) = @_;

It saves me a lot of typing.

=cut

use Filter::Simple;

FILTER_ONLY code_no_comments => sub {

    # sub foo (xxx) { -> sub foo { my (xxx) = @_;
    s{ ^ (\s*) sub (\s+) (\w+) (\s*) \( ([^)]+) \) (\s*) \{ (\s*) }
     {${1}sub${2}${3}${4}${6}\{${7}my (${5}) = \@_;${7}}gmsx;

    # sub foo (xxx) :method { -> sub foo :method { my ($self,xxx) = @_;
    s{ ^ (\s*) sub (\s+) (\w+) (\s*) \( ([^)]+) \) (\s*:method\s*) \{ (\s*) }
     {${1}sub${2}${3}${4}${6}\{${7}my ( \$self, ${5}) = \@_;${7}}gmsx;

    # method foo (xxx) { -> sub foo :method { my ($self,xxx) = @_;
    s{ ^ (\s*) method (\s+) (\w+) (\s*) \( ([^)]+) \) (\s*) \{ (\s*) }
     {${1}sub${2}${3}${4}:method${6}\{${7}my ( \$self, ${5} ) = \@_;${7}}gsmx;

};

=head1 AUTHOR

Johan Vromans, C<< <JV at cpan.org> >>

=head1 SUPPORT AND DOCUMENTATION

Development of this module takes place on GitHub:
https://github.com/sciurius/perl-signatures.

You can find documentation for this module with the perldoc command.

    perldoc signatures

Please report any bugs or feature requests using the issue tracker on
GitHub.

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2021 Johan Vromans, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of signatures
