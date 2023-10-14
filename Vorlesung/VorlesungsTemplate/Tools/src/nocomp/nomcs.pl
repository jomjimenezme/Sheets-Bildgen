#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-out:\s*(\S+)/)
{ $target = $1; }
elsif ($args =~ /(\S+)\.cs/)
{ $target = $1 . ".exe"; }
else
{ die "nomcs: target not recognized\n"; }
`touch $target`;
