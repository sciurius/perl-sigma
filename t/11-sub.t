#! perl

use Test::More tests => 1;

use sigma;

test( <<'EOD', <<'EOD', "filtered" );
sub foo ($x, $y) { # Hello
    ...;
}
EOD
sub foo  { my ($x, $y) = @_; # Hello
    ...;
}
EOD

sub test {
    my ( $input, $xp, $tag ) = @_;
    my $output = "";
    close(STDIN);
    open( STDIN, '<', \$input );
    close(STDOUT);
    open( STDOUT, '>', \$output );
    sigma::filter();
    is( $output, $xp, $tag );
}

