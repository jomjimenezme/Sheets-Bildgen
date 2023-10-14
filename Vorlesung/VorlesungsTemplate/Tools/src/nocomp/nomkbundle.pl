#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-o\s*(\S+)/)
{ $target = $1; }
else
{ die "nomkbundle: target not recognized\n"; }
`touch $target`;
