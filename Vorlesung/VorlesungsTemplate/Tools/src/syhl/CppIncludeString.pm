package CppIncludeString;

@ISA = (LanguageElement);

use List::Util qw(min max);

sub new
{
    my ($class) = @_;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    my $self = $_[0];
    $scanText = \${$_[1]};
    @changes = ();
    $lastPos = 0;
    if ($LanguageElement::sensitive)
    { $casestring = "#include <"; }
    else
    { $casestring = "#INCLUDE <"; }
  LOOP: while (($lastPos = index($$scanText, $casestring, $lastPos)) > -1)
  {
      if (($lastPos > 0 && substr($$scanText, $lastPos - 1, 1) ne "\n"))
      {
          $lastPos++;
          next LOOP;
      }
      push @changes, StyleChange->new($lastPos + 9, $self);
      $commentEndPos = $lastPos + 10;
      $commentEndPos = index($$scanText, ">", $commentEndPos);
      $lastPos = $commentEndPos + 1 if $lastPos > -1;
  }
    return @changes;
}

sub writeOutput
{
    my $self = $_[0];
    $inputText = \${$_[1]};
    $formattedText = \${$_[2]};
    $outputStyle = \%{$_[3]};
    $currentPos = \${$_[4]};
    $commentEndPos = index($$inputText, ">", $$currentPos + 1);
    $commentEndPos += 1;
    $$formattedText .= $outputStyle->{string};
    $$formattedText .= main::formatOutput(substr($$inputText, $$currentPos,
                                                 $commentEndPos - $$currentPos),
                                          $outputStyle, 1);
    $$formattedText .= $outputStyle->{basic};
    $$currentPos = $commentEndPos;
}

1;
