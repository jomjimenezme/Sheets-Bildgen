#!/usr/bin/perl -w

$args = join " ", @ARGV;
if ($args =~ /(\S+)\.p/)
{
    $target = $1;
    $unitline = `grep unit $target.p`;
    if ($unitline =~ /unit\s+(\S+);/)
    { $target = $1 . ".ppu"; }
}
else
{ die "nodelphic: target not recognized\n"; }
`touch $target`;
