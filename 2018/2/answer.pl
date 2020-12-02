#!/usr/bin/perl
use 5.012;
use strict;
use warnings;

use Test::More tests => 10;

my $unique_code = 'abcdef';
my $doublet_code= 'abcdee';
my $triplet_code= 'abcccd';
my $full_house  = 'bababc';

ok !containsDoublet($unique_code), "\"$unique_code\" doesn't contain a letter repeated twice";
ok containsDoublet($doublet_code), "\"$doublet_code\" contains a letter repeated twice";
ok !containsDoublet($triplet_code), "\"$triplet_code\" doesn't contain a letter repeated twice";
ok containsDoublet($full_house), "\"$full_house\" contains a letter repeated twice";

ok !containsTriplet($unique_code), "\"$unique_code\" doesn't contain a letter repeated three times";
ok !containsTriplet($doublet_code), "\"$doublet_code\" doesn't contain a letter repeated three times";
ok containsTriplet($triplet_code), "\"$triplet_code\" contains a letter repeated three times";
ok containsTriplet($full_house), "\"$full_house\" contains a letter repeated three times";

my @test_data = ( 'abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab');
ok calculateHash(@test_data) == 12, "Hash of \"@test_data\" is 12";

my $test_file = "testfile.txt";
ok hashFile($test_file) == 12, "Hash of \"$test_file\" is 12";

my $hash = hashFile($ARGV[0]);
print "$hash\n";

sub hashFile {
  my ($filename) = @_;
  open my $handle, '<', $filename;
  chomp(my @lines = <$handle>);
  close $handle;

  return calculateHash(@lines);
}

sub calculateHash {
  my @codes = @_;
  my $twos = 0;
  my $threes = 0;
  foreach my $code (@codes) {
    if (containsDoublet($code)) {
      $twos++;
    }
    if (containsTriplet($code)) {
      $threes++;
    }
  }
  return $twos*$threes;
}

sub containsDoublet {
  return containsN($_[0], 2);
}

sub containsTriplet {
  return containsN($_[0], 3);
}

sub containsN {
  my ($code, $n) = @_;
  while (length($code) > 0) {
    my $char = substr $code, 0, 1;
    my $count = $code =~ s/$char//g;
    if ($count == $n) {
      return 1;
    }
  }
  return 0;
}
