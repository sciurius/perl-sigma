# sigma

My personal implementation of basic subroutine and method signatures
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

Also some other OO madness:

    $.foo  ->  $self->{foo}
    @.foo  ->  @{ $self->{foo} }
    %.foo  ->  %{ $self->{foo} }
    .foo() ->  $self->{foo}->()

It saves me a lot of typing.

## INSTALLATION

To install this module, run the following commands:

	perl Makefile.PL
	make
	make test
	make install

SUPPORT AND DOCUMENTATION

Development of this module takes place on GitHub:
https://github.com/sciurius/perl-sigma.

You can find documentation for this module with the perldoc command.

    perldoc sigma

Please report any bugs or feature requests using the issue tracker on
GitHub.

## COPYRIGHT AND LICENCE

Copyright (C) 2021 Johan Vromans

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

