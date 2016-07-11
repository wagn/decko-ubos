#!/usr/bin/perl
#
# This runs after a Wagn AppConfig installation (including accessories).
# This optimizes the process by copying the   authoritative version stamp from
# the db (in the schema_migrations table) into a version.txt
# stamp in the appconfig data dir.

use strict;
use warnings;

use UBOS::Logging;
use UBOS::Utils;

my $hostname    = $config->getResolve( 'site.hostname' );
my $appconfigid = $config->getResolve( 'appconfig.appconfigid' );
my $datadir     = $config->getResolve( 'appconfig.datadir' );
my $tmpdir      = "$datadir/tmp";
my $logfile     = "/var/log/decko/$hostname-$appconfigid.log";
my $codedir     = "/usr/share/decko";

debug( 'decko migrate.pl called for AppConfig:', $appconfigid );

my $tmpcleanresult = UBOS::Utils::myexec( "rm -rf $tmpdir/*" );
if( $tmpcleanresult ) {
    error( "decko error cleaning tmp directory $tmpcleanresult" );
}

if ( $operation eq 'install' || $operation eq 'upgrade' ) {
    my $cmd = "env"
              . " LOGFILE=$logfile"
              . " APPCONFIGID=$appconfigid"
              . " DECKDIR=$datadir"
              . " BUNDLE_GEMFILE=$datadir/Gemfile"
              . " bundle exec $codedir/bin/migrate.rb";
    my $result = UBOS::Utils::myexec( $cmd );
  
    if ($result) {
        error( "decko migration FAILURE. For details see $logfile, cmd = $cmd" );
    } else {
        debug( "decko migration SUCCESS. For details see", $logfile );
    }
}      

# Always restart Passenger, regardless of whether deploy/undeploy/install/uninstall/...
my $restartresult = UBOS::Utils::myexec( "touch $tmpdir/restart.txt" );
if( $restartresult ) {
    error( "decko Restart Failure: $restartresult" );
}

1;
