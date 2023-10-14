sub checkOutputMode
{
    my $modestr = $_[0];

    $outputMode = "ansi" if ($modestr =~ /(ansi|ANSI|esc)/);
    $outputMode = "truecolor" if ($modestr =~ /(true|tc)/);
    $outputMode = "test" if ($modestr =~ /(test|Test)/);
    $outputMode = $modestr if ($modestr =~ /(tex|TeX|latex|LaTeX)/);

    return $outputMode;
}

sub setupOutputStyles
{
    my $outputMode = $_[0];
    my $outStyle = \%{$_[1]};
    my $inputFileName = $_[2];

    if ($outputMode eq "ansi")
    {
        $outStyle->{basic} = "[0m";
        $outStyle->{primaryKeyword} = "[34;1m";
        $outStyle->{secondaryKeyword} = "[34m";
        $outStyle->{docKeyword} = "[34;1m";
        $outStyle->{className} = "[32m";
        $outStyle->{extraKeyword} = "[35m";
        $outStyle->{docComment} = "[31;1m";
        $outStyle->{comment} = "[31;1m";
        $outStyle->{string} = "[0;31m";
        $outStyle->{directive} = "[35m";
        $outStyle->{linenumber} = "[0;37m";
        $outStyle->{interactive} = "[0m";
        $outStyle->{manualEmph} = "[31;42;1m";
        $outStyle->{texEscape} = "[0m";
        $outStyle->{stringSpace} = " ";
        $outStyle->{tabulator} = "        ";
        if ($inputFileName ne "-")
        {
            $outStyle->{header} = "[33;40;1m   ";
            $outStyle->{header} .= $inputFileName;
            $outStyle->{header} .= " " until length($outStyle->{header}) >= 90;
            $outStyle->{header} .= $outStyle->{basic};
            $outStyle->{header} .= "\n";
        }
        else
        {
            $outStyle->{header} = "";
        }
        $outStyle->{footer} = "";
        $outStyle->{tex} = 0;
        $outStyle->{tabSize} = 8;
    }
    elsif ($outputMode eq "truecolor")
    {
        $outStyle->{basic} = "[0m";
        $outStyle->{primaryKeyword} = "[38;2;0;0;255;1m";
        $outStyle->{secondaryKeyword} = "[38;2;0;0;140m";
        $outStyle->{docKeyword} = "[0m[38;2;255;77;0m";
        $outStyle->{className} = "[38;2;0;102;0;1m";
        $outStyle->{extraKeyword} = "[38;2;128;0;128m";
        $outStyle->{docComment} = "[38;2;255;77;0;3m";
        $outStyle->{comment} = "[38;2;255;0;0;3m";
        $outStyle->{string} = "[38;2;179;102;0;3m";
        $outStyle->{directive} = "[38;2;199;20;133;1m";
        $outStyle->{linenumber} = "[38;2;170;251;170m";
        $outStyle->{interactive} = "[38;2;0;128;255;3m";
        $outStyle->{manualEmph} = "[38;2;242;128;0;1m";
        $outStyle->{texEscape} = "[0m";
        $outStyle->{stringSpace} = "␣";
        $outStyle->{tabulator} = "↪       ";
        if ($inputFileName ne "-")
        {
            $outStyle->{header} = "[33;40;1m   ";
            $outStyle->{header} .= $inputFileName;
            $outStyle->{header} .= " " until length($outStyle->{header}) >= 90;
            $outStyle->{header} .= $outStyle->{basic};
            $outStyle->{header} .= "\n";
        }
        else
        {
            $outStyle->{header} = "";
        }
        $outStyle->{footer} = "";
        $outStyle->{tex} = 0;
        $outStyle->{tabSize} = 8;
    }
    elsif ($outputMode eq "test")
    {
        $outStyle->{basic} = "[0m";
        $outStyle->{primaryKeyword} = "[34;1m";
        $outStyle->{secondaryKeyword} = "[34m";
        $outStyle->{docKeyword} = "[34;1m";
        $outStyle->{className} = "[32m";
        $outStyle->{extraKeyword} = "[35m";
        $outStyle->{docComment} = "[31;1;47m";
        $outStyle->{comment} = "[31;1m";
        $outStyle->{string} = "[0;33m";
        $outStyle->{directive} = "[35m";
        $outStyle->{linenumber} = "[0;37m";
        $outStyle->{interactive} = "[34;47m";
        $outStyle->{manualEmph} = "[31;42;1m";
        $outStyle->{texEscape} = "[35;47m";
        $outStyle->{stringSpace} = "[0;37m_" . $outStyle->{string};
        $outStyle->{tabulator} = "<TAB>   ";
        if ($inputFileName ne "-")
        {
            $outStyle->{header} = "[33;40;1m   ";
            $outStyle->{header} .= $inputFileName;
            $outStyle->{header} .= " " until length($outStyle->{header}) == 90;
            $outStyle->{header} .= $outStyle->{basic};
            $outStyle->{header} .= "\n";
        }
        else
        {
            $outStyle->{header} = "";
        }
        $outStyle->{footer} = "";
        $outStyle->{tex} = 0;
    }
    elsif ($outputMode =~ /^tex/)
    {
        $outStyle->{basic} = "\\stdbasicstyle\\color{lstblack}";
        $outStyle->{primaryKeyword} = "\\bfseries\\color{lstkeywordcol}";
        $outStyle->{secondaryKeyword} = "\\color{lstndkeywordcol}";
        $outStyle->{docKeyword} = "\\upshape\\color{lstdockeywordcol}";
        $outStyle->{className} = "\\bfseries\\color{lstprocnamecol}";
        $outStyle->{extraKeyword} = "\\color{lstextrakeywordcol}";
        $outStyle->{docComment} = "\\itshape\\color{lstjavadoccol}";
        $outStyle->{comment} = "\\itshape\\color{lstcommentcol}";
        $outStyle->{string} = "\\stdbasicstyle\\slshape\\color{lststringcol}";
        $outStyle->{directive} = "\\bfseries\\color{lstdirectivecol}";
        $outStyle->{linenumber} = "\\mdseries\\sffamily\\scriptsize\\color{lstnumbercol}";
        $outStyle->{interactive} = "\\itshape\\color{lstinteractcol}";
        $outStyle->{manualEmph} = "\\bfseries\\color{lstmanualemphcol}";
        $outStyle->{texEscape} = "";
        $outStyle->{stringSpace} = "{}\\textvisiblespace{}";
        $outStyle->{tabulator} = "\\makebox[11ex][l]{\$\\hookrightarrow\$}";
        $outStyle->{footer} = "";
        $outStyle->{tex} = 1;
        $outStyle->{texscale} = 1;
        if ($inputFileName ne "-")
        {
            $outStyle->{header} .= $inputFileName;
        }
        else
        {
            $outStyle->{header} = "$outStyle->{basic}%\n";
        }
        if ($outputMode =~ /\-smaller/)
        {
            $outStyle->{texscale} = 0.6944;
        }
        elsif ($outputMode =~ /\-sesquismall/)
        {
            $outStyle->{texscale} = 0.7607;
            $outStyle->{extraLineskip} = 1;
        }
        elsif ($outputMode =~ /\-small/)
        {
            $outStyle->{texscale} = 0.8333;
        }
        elsif ($outputMode =~ /\-list2pr/)
        {
            $outStyle->{texscale} = 0.8333;
            $outStyle->{extraLineskip} = 0.8;
        }
        if ($outputMode =~ /\-alg/)
        {
            $outStyle->{texalg} = 1;
        }
        if ($outputMode =~ /inline/)
        {
            $outStyle->{texinline} = 1;
        }
    }
}
