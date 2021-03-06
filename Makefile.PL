#! perl

use strict;
use warnings;

exit 0 if $ENV{AUTOMATED_TESTING} && $] < 5.010001;

# EU::MM 6.5503 is the first version to understand *_REQUIRES.
use ExtUtils::MakeMaker 6.5503;

# For binaries/scripts.
my @bins; # = qw( prog );

WriteMakefile(
    NAME                => 'sigma',
    AUTHOR              => 'Johan Vromans <jv@cpan.org>',
    VERSION_FROM        => 'lib/sigma.pm',
    ABSTRACT_FROM       => 'lib/sigma.pm',
    LICENSE             => 'perl_5',
    PL_FILES            => {},
    MIN_PERL_VERSION    => '5.010001',

    @bins == 0 ? () : (
      EXE_FILES         => [ map { "script/$_" } @bins ],
      PL_FILES          => {
                             'script/pp.PL' => [ map { "script/$_" } @bins ]
                           },
    ),

    PREREQ_PM => {
      'ExtUtils::MakeMaker' => 6.5503, # for META_MERGE, LICENSE, *_REQUIRES
      'Test::More'          => 0,
    },

    META_MERGE => {
      resources    => {
        repository => 'https://github.com/sciurius/perl-sigma',
        bugtracker => "https://github.com/sciurius/perl-sigma/issues",
        license    => "https://dev.perl.org/licenses/",
      },
      'meta-spec' => {
        version => '2',
        url     => 'https://metacpan.org/pod/CPAN::Meta::Spec',
      },
    },
);
