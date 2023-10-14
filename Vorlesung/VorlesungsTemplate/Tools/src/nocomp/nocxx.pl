#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-o\s*(\S+)/)
{ $target = $1; }
elsif ($args =~ /-c/ && $args =~ /(\S+)\.cc/)
{ $target = $1 . ".o"; }
else
{ die "nocxx: target not recognized\n"; }
`touch $target`;
