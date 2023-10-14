#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /(\S+)\.java/)
{ $target = $1 . ".class"; }
else
{ die "nojbc: target not recognized\n"; }
`touch $target`;
