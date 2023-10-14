package Delimited;

@ISA = (LanguageElement);

use List::Util qw(min max);

sub new
{
    my ($class, $b, $e, $t, $st) = @_;
    my $self = {};
    $self->{beg} = $b;
    $self->{end} = $e;
    $self->{type} = $t;
    $self->{stringtype} = defined($st) ? $st : "none";
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    my $self = $_[0];
    $scanText = \${$_[1]};
    @changes = ();
    $lastPos = 0;
  LOOP: while (($lastPos = index($$scanText, $self->{beg}, $lastPos)) > -1)
  {
      ## check for backslash-escaped string beginner
      if ($self->{stringtype} eq "backslash" && $lastPos > 0
          && substr($$scanText, $lastPos - 1, 1) eq "\\")
      {
          $lastPos++;
          next LOOP;
      }
      ## check for Matlab transpose character
      if ($self->{stringtype} eq "matlab" && $lastPos > 0
          && substr($$scanText, $lastPos - 1, 1) =~ /(\w|\))/)
      {
          $lastPos++;
          next LOOP;
      }
      ## found delimiter start
      push @changes, StyleChange->new($lastPos, $self);
      $commentEndPos = $lastPos + length($self->{beg});
      $commentEndPos = index($$scanText, $self->{end}, $commentEndPos);
      return @changes if $commentEndPos == -1;
      ## check for backslash-escaped string terminators
      while ($self->{stringtype} eq "backslash"
             && substr($$scanText, $commentEndPos - 1, 1) eq "\\"
             && ($commentEndPos  < 2 ||
                 substr($$scanText, $commentEndPos - 2, 1) ne "\\"))
      { $commentEndPos = index($$scanText, $self->{end},
                               $commentEndPos + 1); }
      return @changes if $commentEndPos == -1;
      ## check for continued comment lines
      $lastEolPos = $lastPos;
      while (($lastEolPos = index($$scanText, "\n", $lastEolPos))
             < $commentEndPos)
      {
          last if $lastEolPos == -1;
          push @changes, StyleChange->new($lastEolPos + 1, $self, $lastPos);
          $lastEolPos++;
      }
      #$lastPos = $commentEndPos + length($self->{end}) if $lastPos > -1;
      $lastPos = $commentEndPos if $lastPos > -1;
  }
    return @changes;
}

sub writeOutput
{
    my $self = $_[0];
    $inputText = \${$_[1]};
    $formattedText = \${$_[2]};
    $outputStyle = \%{$_[3]};
    my $currentPos = \${$_[4]};
    ## comment ends at self->end or at eol
    my $commentEndPos;
    if ($$currentPos != 0 && substr($$inputText, $$currentPos - 1, 1) eq "\n"
        && substr($$inputText, $$currentPos, length($self->{beg}))
        ne $self->{beg})
    {
        $commentEndPos = index($$inputText, $self->{end}, $$currentPos);
    }
    else
    {
        $commentEndPos = index($$inputText, $self->{end},
                               $$currentPos + length($self->{beg}));
    }
    my $eolPos = index($$inputText, "\n", $$currentPos) - 1;
    if ($eolPos > -1 && $eolPos < $commentEndPos)
    { $commentEndPos = $eolPos; }
    ## check for backslash-escaped string terminators
    while ($self->{stringtype} eq "backslash" && $$currentPos > 0
           && substr($$inputText, $commentEndPos - 1, 1) eq "\\"
           && ($commentEndPos  < 2 ||
               substr($$inputText, $commentEndPos - 2, 1) ne "\\"))
    { $commentEndPos = index($$inputText, $self->{end},  $commentEndPos + 1); }
    if ($commentEndPos != $eolPos)
    {
        $commentEndPos += length($self->{end});
    }
    else
    {
        $commentEndPos += 1;
    }
    my $where = $self->{stringtype} =~ /(normal|backslash|matlab)/ ? "inString"
        : "other";
    $$formattedText .= $outputStyle->{$self->{type}};
    $$formattedText .= main::formatOutput(substr($$inputText, $$currentPos,
                                                 $commentEndPos - $$currentPos),
                                          $outputStyle, $where);
    $$formattedText .= $outputStyle->{basic};
    $$currentPos = $commentEndPos;
}

1;
