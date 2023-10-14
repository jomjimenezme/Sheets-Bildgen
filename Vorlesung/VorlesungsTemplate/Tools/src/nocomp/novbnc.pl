#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-out:\s*(\S+)/)
{ $target = $1; }
elsif ($args =~ /(\S+)\.vb/)
{ $target = $1 . ".exe"; }
else
{ die "novbnc: target not recognized\n"; }
`touch $target`;
