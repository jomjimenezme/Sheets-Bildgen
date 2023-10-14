#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /(\S+)\.lisp/)
{ $target = $1 . ".fas"; }
else
{ die "nolisp: target not recognized\n"; }
`touch $target`;
