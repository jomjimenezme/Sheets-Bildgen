#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-o\s*(\S+)/)
{ $target = $1; }
elsif ($args =~ /-c/ && $args =~ /(\S+)\.d/)
{ $target = $1 . ".o"; }
else
{ die "nodc: target not recognized\n"; }
`touch $target`;
