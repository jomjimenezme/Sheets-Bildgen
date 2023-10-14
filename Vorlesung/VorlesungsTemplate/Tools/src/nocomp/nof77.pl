#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-o\s*(\S+)/)
{ $target = $1; }
elsif ($args =~ /-c/ && $args =~ /(\S+)\.f/)
{ $target = $1 . ".o"; }
else
{ die "nof77: target not recognized\n"; }
`touch $target`;
