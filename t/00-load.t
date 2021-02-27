#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'signatures' );
}

diag( "Testing signatures $signatures::VERSION, Perl $], $^X" );
