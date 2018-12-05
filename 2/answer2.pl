#!/usr/bin/perl
use 5.012;
use strict;
use warnings;

use Test::More tests => 3;

my $code1= 'abcdef';
my $code2= 'abcdee';
my $code3= 'abccde';
my $code4= 'acccde';

my @codes1=($code1, $code2, $code3);
ok findSimilar(@codes1) eq "abcde", "\"$code1\" and \"$code2\" share \"abcde\"";

my @codes2=($code1, $code3, $code4);
ok findSimilar(@codes2) eq "accde", "\"$code3\" and \"$code4\" share \"accde\"";

my $test_file = "testfile2.txt";
ok scanFile($test_file) eq "fgij", "Match in \"$test_file\" is fgij";

my $match = scanFile($ARGV[0]);
print "$match\n";

sub scanFile {
  my ($filename) = @_;
  open my $handle, '<', $filename;
  chomp(my @lines = <$handle>);
  close $handle;

  return findSimilar(@lines);
}

sub findSimilar {
  my @codes = @_;

  for (my $i=0; $i < length($codes[0]); $i++) {
    my %subcodes = ();
    foreach my $code (@codes){
      my $subcode = substr($code, 0, $i) . substr($code,$i+1);
      if (exists $subcodes{$subcode}) {
          return $subcode;
      }
      else {
        $subcodes{$subcode}=1;
      }
    }
  }
}
