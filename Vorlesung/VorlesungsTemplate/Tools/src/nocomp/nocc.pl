#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /-o\s*(\S+)/)
{ $target = $1; }
elsif ($args =~ /-c/ && $args =~ /(\S+)\.c/)
{ $target = $1 . ".o"; }
else
{ die "nocc: target not recognized\n"; }
`touch $target`;
