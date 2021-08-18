#! perl

use Test::More tests => 1;

use sigma;

my $input = <<'EOD';
sub foo ($x, $y) {
    ...;
}
EOD

my $xp = <<'EOD';
sub foo  { my ($x, $y) = @_;
    ...;
}
EOD

my $output = "";
close(STDIN);
open( STDIN, '<', \$input );
close(STDOUT);
open( STDOUT, '>', \$output );

sigma::filter();

is( $output, $xp, "filtered" );
