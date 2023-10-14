#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-o\s*(\S+)/)
{ $target = $1; }
elsif ($args =~ /-c/ && $args =~ /(\S+)\.f90/)
{ $target = $1 . ".o"; }
else
{ die "nof90: target not recognized\n"; }
`touch $target`;
