#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-o\s*(\S+)/)
{ $target = $1; }
elsif ($args =~ /-c/ && $args =~ /(\S+)\.java/)
{ $target = $1 . ".o"; }
elsif ($args =~ /-C/ && $args =~ /(\S+)\.java/)
{ $target = $1 . ".class"; }
else
{ die "nojc: target not recognized\n"; }
`touch $target`;
