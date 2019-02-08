use Test2::V0 -no_srand => 1;
use Test::Alien;
use Alien::Librdkafka;
use version;

alien_ok 'Alien::Librdkafka';
my $xs = do { local $/; <DATA> };
xs_ok $xs, with_subtest {
  my $version = librdkafka::rd_kafka_version_str();
  ok(version->parse($version) >= version->parse($Alien::Librdkafka::VERSION), "library version is at least $Alien::Librdkafka::VERSION");
  note "version = $version";
};

diag '';
diag '';
diag '';

diag 'Alien::Librdkafka->version = ', Alien::Librdkafka->config('version');
diag 'Alien::Librdkafka->cflags  = ', Alien::Librdkafka->cflags;
diag 'Alien::Librdkafka->libs    = ', Alien::Librdkafka->libs;

diag '';
diag '';

done_testing;

__DATA__

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <librdkafka/rdkafka.h>

MODULE = librdkafka PACKAGE = librdkafka

const char *
rd_kafka_version_str()
