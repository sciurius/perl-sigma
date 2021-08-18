#! perl

use Test::More tests => 3;

use sigma;

test( <<'EOD', <<'EOD', "hash" );
%.foo = qw( a b c );
EOD
%{ $self->{foo} } = qw( a b c );
EOD

test( <<'EOD', <<'EOD', "hash" );
if ( %.foo ) {
    ...;
}
EOD
if ( %{ $self->{foo} } ) {
    ...;
}
EOD

test( <<'EOD', <<'EOD', "hash" );
$.foo = keys(%.bar);
EOD
$self->{foo} = keys(%{ $self->{bar} });
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

