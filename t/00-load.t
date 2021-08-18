#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'sigma' );
}

diag( "Testing sigma $sigma::VERSION, Perl $], $^X" );
