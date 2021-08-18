#! perl

use Test::More tests => 3;

use sigma;

test( <<'EOD', <<'EOD', "array" );
@.foo = qw( a b c );
EOD
@{ $self->{foo} } = qw( a b c );
EOD

test( <<'EOD', <<'EOD', "array" );
if ( @.foo ) {
    ...;
}
EOD
if ( @{ $self->{foo} } ) {
    ...;
}
EOD

test( <<'EOD', <<'EOD', "array" );
$.foo = scalar(@.bar);
EOD
$self->{foo} = scalar(@{ $self->{bar} });
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

