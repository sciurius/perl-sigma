#! perl

use Test::More tests => 4;

use sigma;

test( <<'EOD', <<'EOD', "basic" );
sub foo ($x, $y) :method {
    ...;
}
EOD
sub foo  :method { my ($self, $x, $y) = @_;
    ...;
}
EOD

test( <<'EOD', <<'EOD', "w/ comment" );
sub foo ($x, $y) :method { # Hello
    ...;
}
EOD
sub foo  :method { my ($self, $x, $y) = @_; # Hello
    ...;
}
EOD

test( <<'EOD', <<'EOD', "method" );
method foo ($x, $y) {
    ...;
}
EOD
sub foo :method { my ($self, $x, $y) = @_;
    ...;
}
EOD

test( <<'EOD', <<'EOD', "w/ comment" );
method foo ($x, $y) { # Hello
    ...;
}
EOD
sub foo :method { my ($self, $x, $y) = @_; # Hello
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

