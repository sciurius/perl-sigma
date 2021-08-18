#! perl

use Test::More tests => 3;

use sigma;

test( <<'EOD', <<'EOD', "call" );
.foo->( a b c );
EOD
$self->{foo}->( a b c );
EOD

test( <<'EOD', <<'EOD', "call" );
if ( .foo->() ) {
    ...;
}
EOD
if ( $self->{foo}->() ) {
    ...;
}
EOD

test( <<'EOD', <<'EOD', "call" );
$.foo = .bar->(42);
EOD
$self->{foo} = $self->{bar}->(42);
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

