package EolComment;

@ISA = (LanguageElement);

sub new
{
    my ($class, $b, $t, $p) = @_;
    my $self = {};
    $self->{beg} = $b;
    $self->{type} = defined($t) ? $t : "comment";
    $self->{isPerl} = defined($p);
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    my $self = $_[0];
    $scanText = \${$_[1]};
    @changes = ();
    $lastPos = 0;
  LOOP:while (($lastPos = index($$scanText, $self->{beg}, $lastPos)) > -1)
  {
      if ($self->{isPerl} && $lastPos != 0
          && substr($$scanText, $lastPos - 1, 1) =~ /(\$|\^)/)
      {
          $lastPos++;
          next LOOP;
      }
      push @changes, StyleChange->new($lastPos, $self);
  }
    continue
  { $lastPos++; }

    return @changes;
}

sub writeOutput
{
    my $self = $_[0];
    $inputText = \${$_[1]};
    $formattedText = \${$_[2]};
    $outputStyle = \%{$_[3]};
    $currentPosition = \${$_[4]};
    $commentEndPosition = index($$inputText, "\n", $$currentPosition + 1);
    if ($commentEndPosition == -1) ## no eol after last line
    { $commentEndPosition = length($$inputText); }
    $$formattedText .= $outputStyle->{$self->{type}};
    $$formattedText .= main::formatOutput(substr($$inputText, $$currentPosition,
                                                 $commentEndPosition
                                                 - $$currentPosition),
                                          $outputStyle);
    $$formattedText .= $outputStyle->{basic};
    $$currentPosition = $commentEndPosition;
}

1;
