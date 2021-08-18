#! perl

use Test::More tests => 1;

use sigma;

my $xp = "Hello, World!";

sub sigmatest ($arg ) {
    is( $arg, $xp );
}

sigmatest( "Hello, World!" );
