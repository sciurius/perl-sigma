#! perl

use Test::More tests => 3;

use sigma;

test( <<'EOD', <<'EOD', "scalar" );
$.foo = 1;
EOD
$self->{foo} = 1;
EOD

test( <<'EOD', <<'EOD', "scalar" );
if ( $.foo ) {
    ...;
}
EOD
if ( $self->{foo} ) {
    ...;
}
EOD

test( <<'EOD', <<'EOD', "scalar" );
$.foo = $.bar[1];
EOD
$self->{foo} = $self->{bar}[1];
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

