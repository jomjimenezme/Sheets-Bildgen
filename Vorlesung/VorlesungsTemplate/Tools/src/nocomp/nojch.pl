#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /\s+(\S+)$/)
{ $target = $1 . ".h"; }
else
{ die "nojch: target not recognized\n"; }
`touch $target`;
