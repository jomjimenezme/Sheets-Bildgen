sub checkLanguage
{
    my $langstr = $_[0];

    $language = "check";
    $language = "NoLang" if ($langstr =~ /(NoLang|nolang|no)/);
    $language = "C"      if ($langstr =~ /(c|C)/);
    $language = "CEscape"if ($langstr =~ /CEsc/);
    $language = "C++"    if ($langstr =~ /(cc|CC|cxx|CXX|cpp|CPP|c\+\+|C\+\+)/);
    $language = "C++Escape"
        if ($langstr =~ /CCEsc/);
    $language = "Java"   if ($langstr =~ /(java|Java|JAVA)/);
    $language = "JavaEscape"
        if ($langstr =~ /JavaEsc/);
    $language = "D"      if ($langstr =~ /^(d|D)$/);
    $language = "CS"     if ($langstr =~ /(cs|csharp|CS)/);
    $language = "F77"    if ($langstr =~ /^(f|F|f77|F77)/);
    $language = "F90"    if ($langstr =~ /(f90|F90|f95|F95)/);
    $language = "Pascal" if ($langstr =~ /^(pas|PAS|pascal|Pascal)/);
    $language = "Basic"  if ($langstr =~ /^(bas|basic|Basic|BASIC|vb|VB)/);
    $language = "Perl"   if ($langstr =~ /(perl|Perl|pl)/);
    $language = "Python" if ($langstr =~ /(python|Python|py|Py)/);
    $language = "PythonEscape"
        if ($langstr =~ /PyEsc/);
    $language = "Bash"   if ($langstr =~ /(bash|Bash|sh|SH)/);
    $language = "BashEscape"
        if ($langstr =~ /SHEsc/);
    $language = "JavaSH" if ($langstr =~ /(javash|JavaSH)/);
    $language = "Matlab" if ($langstr =~ /(matlab|Matlab)/);
    $language = "Stateflow"
        if ($langstr =~ /Stateflow/);
    $language = "Octave" if ($langstr =~ /(octave|Octave)/);
    $language = "Prolog" if ($langstr =~ /(pro|prolog|Prolog)/);
    $language = "PrologEscape"
        if ($langstr =~ /PrologEsc/);
    $language = "Lisp"   if ($langstr =~ /(lisp|Lisp)/);
    $language = "LispEscape"
        if ($langstr =~ /LispEsc/);
    $language = "Make"   if ($langstr =~ /(make|Make|makefile|Makefile)/);
    $language = "autoconf"
        if ($langstr =~ /AutoConf/);
    $language = "SQL"    if ($langstr =~ /(sql|SQL)/);
    $language = "HTML"   if ($langstr =~ /(html|HTML)/);
    $language = "xml"    if ($langstr =~ /(xml|XML)/);
    $language = "QML"    if ($langstr =~ /(qml|QML)/);
    $language = "EL"    if ($langstr =~ /(EL)/);
    $language = "Mathematica"
        if ($langstr =~ /(math|mathematica|Mathematica)/);
    $language = "latex"  if ($langstr =~ /(tex|Tex|TeX|latex|Latex|LaTeX)/);
    $language = "latex-math"
        if ($langstr =~ /latex-math/);
    $language = "Interactive"
        if ($langstr =~ /(interactive|Interactive)/);
    $language = "InteractiveEscape"
        if ($langstr =~ /InteractiveEsc/);
    $language = "Algorithm"
        if ($langstr =~ /(alg|Alg|algorithm|Algorithm)/);
    $language = "EBNF"
        if ($langstr =~ /(ebnf|EBNF)/);
    $language = "Alg-comment"
        if ($langstr =~ /Alg-comment/);
    $language = "Alg-string"
        if ($langstr =~ /Alg-string/);
    $language = "Javadoc"
        if ($langstr =~ /Javadoc/);
    $language = "Doxygen"
        if ($langstr =~ /Doxygen/);
    $language = "AllComment"
        if ($langstr =~ /AllComment/);
    $language = "AllString"
        if ($langstr =~ /AllString/);
    $language = "AllStringEscape"
        if ($langstr =~ /AllStringEsc/);
    $language = "AllDirective"
        if ($langstr =~ /AllDirective/);
    $language = "AllDocKeyword"
        if ($langstr =~ /AllDocKeyword/);
    $language = "Test"   if ($langstr =~ /(test|Test)/);
    $language = "check"  if ($langstr =~ /check/);

    ($sublanguage) = $langstr =~ /(@.+)$/;
    if (!defined($sublanguage))
    { $sublanguage = ""; }

    return $language . $sublanguage;
}

sub guessLanguage
{
    my $inputFileName = $_[0];

    $language = "C"      if $inputFileName =~ /\.c$/;
    $language = "C++"    if $inputFileName =~ /\.(cc|cpp|cxx|h|C)$/;
    $language = "Java"   if $inputFileName =~ /\.java$/;
    $language = "JavaSH"   if $inputFileName =~ /\.javash$/;
    $language = "D"      if $inputFileName =~ /\.d$/;
    $language = "CS"     if $inputFileName =~ /\.cs$/;
    $language = "F77"    if $inputFileName =~ /\.f$/;
    $language = "F90"    if $inputFileName =~ /\.(f90|f95)$/;
    $language = "Pascal" if $inputFileName =~ /\.(p|P|pas|PAS)$/;
    $language = "Basic"  if $inputFileName =~ /\.(bas|vb|VB)$/;
    $language = "Perl"   if $inputFileName =~ /\.(pl|pm)$/;
    $language = "Python" if $inputFileName =~ /\.py$/;
    $language = "Bash"   if $inputFileName =~ /\.sh$/;
    $language = "Matlab" if $inputFileName =~ /\.m$/;
    $language = "Lisp"   if $inputFileName =~ /\.(lisp|el)$/;
    $language = "Make"   if $inputFileName =~ /(M|m)akefile$/;
    $language = "autoconf"
        if $inputFileName =~ /\.(scan|ac)$/;
    $language = "SQL"    if $inputFileName =~ /\.sql$/;
    $language = "HTML"   if $inputFileName =~ /\.(html|htm|jsp)$/;
    $language = "xml"    if $inputFileName =~ /\.(xml|qrc)$/;
    $language = "QML"    if $inputFileName =~ /\.qml$/;
    $language = "latex"  if $inputFileName =~ /\.tex$/;
    $language = "Mathematica"
        if $inputFileName =~ /\.ma$/;
    $language = "Test"   if $inputFileName =~ /\.test$/;
    $language = "NoLang" if $language =~ /check/;

    return $language;
}

sub setupLanguageData
{
    my $language = $_[0];
    my $langData = \%{$_[1]};

    if ($language =~ /@/)
    { ($language, $sublanguage) = ($language =~ /(.*?)(@.*)/); }
    else
    { $sublanguage = ""; }

    if ($language eq "Test")
    {
        $langData->{primaryKeywords} = [ "important", "keyword" ];
        $langData->{alwaysKeywords} = [ "within" ];
        $langData->{secondaryKeywords} = [ "secondary" ];
        $langData->{classnameKeywords} = [ "class" ];
        $langData->{alsoLetters} = "[=~]";
        # the following must be given as triples.
        $langData->{eolCommentsRec} = [ "////", "C", "test" ];
        # the following must be given as triples.
        $langData->{eolDocComments} = [ "///", "C", "test" ];
        $langData->{eolComments} = [ "//" ];
        $langData->{fortComments} = [ ";" ];
        $langData->{colNumComments} = [ 74 ];
        # the following must be given as quadruples.
        $langData->{brDocComments} = [ "/**", "*/", "C", "test" ];
        # the following must be given as quadruples.
        $langData->{brCommentsRec} = [ "(*", "*)", "C", "test" ];
        $langData->{brComments} = [ "/*", "*/" ];
        # the following must be given as quadruples.
        $langData->{normalStringRec} = [ '``', "''", "C", "test" ];
        $langData->{normalString} = [ '`' ];
        $langData->{normalString2} = [ '---', '___' ];
        $langData->{backslashString} = [ '"' ];
        $langData->{matlabString} = [ "'" ];
        $langData->{directives} = [ "define", "include" ];
        $langData->{cppIncludeString} = 1;
        # the following must be given as pairs
        $langData->{interactive} = [ "§", "§" ];
        $langData->{manualEmph} = [ "µ", "µ" ];
        # the following must be given as triples.
        $langData->{texEscape} = [ '$', '$', '$', '@', '{\large', '}' ];
        # the following must be given as pairs.
        $langData->{literate} = [ "big", "BIG" ];
        $langData->{sensitive} = 0;
        $langData->{showTabs} = 1;
    }
    elsif ($language eq "C" || $language eq "CEscape")
    {
        $langData->{primaryKeywords} = [ "auto", "break", "case", "char",
                                         "const", "continue", "default", "do",
                                         "double", "else", "extern", "float",
                                         "for", "goto", "if", "int", "long",
                                         "register", "return", "short",
                                         "signed", "sizeof", "static", "switch",
                                         "typedef", "unsigned", "void",
                                         "volatile", "while",
                                         "inline", "restrict", "_Bool",
                                         "_Complex", "_Imaginary",
                                         "_Alignas", "_Alignof", "_Atomic",
                                         "_Generic", "_Noreturn",
                                         "_Static_assert", "_Thread_local"
            ];
        $langData->{secondaryKeywords} = [ "abort", "assert", "atan", "bool",
                                           "calloc", "ceil", "char16_t",
                                           "char32_t", "CHAR_MAX", "CHAR_MIN",
                                           "cimag", "clearerr", "complex",
                                           "cos", "creal", "difftime", "EOF",
                                           "exit", "EXIT_FAILURE",
                                           "EXIT_SUCCESS", "exp", "fabs",
                                           "false", "fclose", "feof", "ferror",
                                           "fflush", "fgetc", "fgets", "fgetws",
                                           "FILE", "floor", "fmod", "fopen",
                                           "fprintf", "fputc", "fputs", "fread",
                                           "free", "fscanf", "fseek", "fwrite",
                                           "getchar", "gets", "I", "int32_t",
                                           "INT_MAX", "INT_MIN", "isalnum",
                                           "isalpha", "iscntrl", "isdigit",
                                           "isgraph", "islower", "isprint",
                                           "ispunct", "isspace", "isupper",
                                           "iswalpha", "isxdigit", "LC_ALL",
                                           "LLONG_MIN", "LLONG_MAX", "log",
                                           "log10", "LONG_MAX", "LONG_MIN",
                                           "main", "malloc", "MB_CUR_MAX",
                                           "mblen", "mbstowcs", "NULL",
                                           "perror", "pow", "printf", "putchar",
                                           "puts", "putwchar", "rand",
                                           "RAND_MAX", "remove", "rename",
                                           "round", "scanf", "SCHAR_MAX",
                                           "SCHAR_MIN", "setlocale", "SHRT_MAX",
                                           "SHRT_MIN", "sin", "size_t", "sqrt",
                                           "sscanf", "sprintf", "stderr",
                                           "stdin", "stdout", "strcmp",
                                           "strcpy", "strlen", "strncpy", "tan",
                                           "time", "tolower", "toupper",
                                           "towupper", "true", "UCHAR_MAX",
                                           "uint_least32_t", "UINT_MAX",
                                           "ULLONG_MAX", "ULONG_MAX",
                                           "USHRT_MAX", "va_arg", "va_end",
                                           "va_list", "va_start", "wchar_t",
                                           "wcslen", "wcstombs", "wctomb",
                                           "wprintf"
            ];
        $langData->{classnameKeywords} = [ "enum", "struct", "union"
            ];
        $langData->{eolComments} = [ "//" ];
        $langData->{brComments} = [ "/*", "*/" ];
        $langData->{backslashString} = [ "'", '"' ];
        $langData->{backslashString2} = [ "L'", "'", 'L"', '"' ];
        $langData->{directives} = [ "define", "elif", "else", "endif", "error",
                                    "if defined", "if", "ifdef", "ifndef",
                                    "include", "line", "pragma", "undef",
                                    "warning",
                                    " 8", " 11"
            ];
        $langData->{cppIncludeString} = 1;
        if ($language eq "CEscape")
        {
            $langData->{texEscape} = [ 'º', '', '' ];
        }
        if ($sublanguage =~ /BLAS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "dgemm_", "dtrsm_"
                ];
        }
        if ($sublanguage =~ /CBLAS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "cblas_dgemm", "cblas_dtrsm",
                                           "CblasLeft", "CblasLower",
                                           "CblasNoTrans", "CblasRowMajor",
                                           "CblasUnit"
                ];
        }
        if ($sublanguage =~ /f2c/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "doublereal", "MAIN__"
                ];
        }
        if ($sublanguage =~ /LAPACK/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "LAPACKE_dgesv",
                                           "LAPACK_ROW_MAJOR"
                ];
        }
        if ($sublanguage =~ /mex/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "mexErrMsgTxt", "mexFunction",
                                           "mxArray", "mxCreateDoubleMatrix",
                                           "mxGetM", "mxGetN", "mxGetPr",
                                           "mxIsComplex", "mxIsDouble", "mxREAL"
                ];
        }
        if ($sublanguage =~ /MPI/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "MPI_Bcast", "MPI_Comm_rank",
                                           "MPI_Comm_size", "MPI_COMM_WORLD",
                                           "MPI_DOUBLE", "MPI_Finalize",
                                           "MPI_Init", "MPI_Recv", "MPI_Reduce",
                                           "MPI_Send", "MPI_Status", "MPI_SUM"
                ];
        }
        if ($sublanguage =~ /NAG/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "f04arc", "NAG_ALLOC",
                                           "Nag_ColMajor", "nag_dgetrf",
                                           "nag_dgetrs", "NAGERR_DEFAULT",
                                           "NAG_FREE", "Nag_NoTrans",
                                           "nag_real_lin_eqn", "Nag_RowMajor"
                ];
        }
        if ($sublanguage =~ /OPENGL/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "glColor3f", "glPopMatrix",
                                           "glPushMatrix", "glRotated",
                                           "glScaled", "glTranslated",
                                           "glutSolidCube"
                ];
        }
    }
    elsif ($language eq "C++" || $language eq "C++Escape")
    {
        $langData->{primaryKeywords} = [ # from C
                                         "auto", "break", "case", "char",
                                         "const", "continue", "default", "do",
                                         "double", "else", "extern", "float",
                                         "for", "goto", "if", "int", "long",
                                         "register", "return", "short",
                                         "signed", "sizeof", "static", "switch",
                                         "typedef", "unsigned", "void",
                                         "volatile", "while",
                                         # C++
                                         "asm", "bool", "catch", "class",
                                         "const_cast", "delete", "dynamic_cast",
                                         "explicit", "export", "false",
                                         "friend", "inline", "mutable",
                                         "namespace", "new", "operator",
                                         "private", "protected", "public",
                                         "reinterpret_cast", "static_cast",
                                         "template", "this", "throw", "true",
                                         "try", "typeid", "typename", "using",
                                         "virtual", "wchar_t",
                                         # replacements for operators
                                         "and", "and_eq", "bitand", "bitor",
                                         "compl", "not", "not_eq", "or",
                                         "or_eq", "xor", "xor_eq",
                                         # C++11
                                         "alignas", "alignof", "char16_t",
                                         "char32_t", "constexpr", "decltype",
                                         "noexcept", "nullptr", "static_assert",
                                         "thread_local",
                                         # C++20
                                         "char8_t", "co_await", "concept",
                                         "consteval", "constinit", "co_return",
                                         "co_yield", "requires",
            ];
        $langData->{secondaryKeywords} = [ # type from C
                                           "size_t", "va_list",
                                           # functions from C
                                           "abs", "assert", "atoi", "ceil",
                                           "cos", "exit", "floor", "getenv",
                                           "int32_t", "main", "memcpy", "pow",
                                           "printf", "rand", "sin", "sqrt",
                                           "srand", "system", "time", "toupper",
                                           "va_arg", "va_end", "va_start",
                                           # constants from C
                                           #"M_PI", "M_SQRT2",
                                           "NULL",
                                           # special identifiers in C++11
                                           "final", "override",
                                           # special identifiers in C++20
                                           "import", "module",
                                           # namespaces
                                           "std::chrono", "std::numbers",
                                           "std::placeholders", "std",
                                           # classes
                                           "any", "array", "bad_alloc",
                                           "bad_cast", "bad_exception",
                                           "bad_typeid", "bad_function_call",
                                           "bad_weak_ptr", "complex",
                                           "default_delete", "deque",
                                           "duration",
                                           "enable_shared_from_this",
                                           "exception",
                                           "exponential_distribution",
                                           "forward_list", "function",
                                           "ifstream", "initializer_list",
                                           "ios_base", "ios", "istream",
                                           "istream_iterator", "istringstream",
                                           "list", "locale", "lock_guard",
                                           "logic_error", "map", "multimap",
                                           "multiset", "mutex",
                                           "normal_distribution",
                                           "numeric_limits", "pair", "ofstream",
                                           "ostream", "ostream_iterator",
                                           "ostringstream", "osyncstream",
                                           "out_of_range", "packaged_task",
                                           "pos_type", "priority_queue",
                                           "promise", "queue", "random_device",
                                           "ratio", "reference_wrapper",
                                           "regex", "runtime_error", "set",
                                           "shared_future", "shared_ptr",
                                           "smatch", "stack", "string",
                                           "strong_ordering", "system_clock",
                                           "system_error", "thread",
                                           "type_info",
                                           "uniform_int_distribution",
                                           "unique_lock", "unique_ptr",
                                           "unordered_map",
                                           "unordered_multimap",
                                           "unordered_multiset",
                                           "unordered_set", "u16string",
                                           "u32string", "u8string", "vector",
                                           "weak_ptr", "wistream", "wostream",
                                           "wstring",
                                           # traits
                                           "is_arithmetic", "is_floating_point",
                                           # types
                                           "nullptr_t",
                                           # typedefs
                                           "default_random_engine",
                                           "exception_ptr", "mt19937",
                                           # objects
                                           "cerr", "cin","clog", "cout", "wcin",
                                           "wcout", "_1",
                                           # function objects
                                           "bind1st", "bind2nd", "bind",
                                           "equal_to", "greater",
                                           "greater_equal", "less",
                                           "less_equal", "multiplies",
                                           # functions
                                           "async", "back_inserter",
                                           "boolalpha", "clamp", "copy",
                                           "count", "count_if", "dec",
                                           "declval", "defaultfloat", "endl",
                                           "ends", "exp", "find", "find_if",
                                           "fixed", "flush", "forward",
                                           "for_each", "getline", "hex",
                                           "inplace_merge", "internal", "left",
                                           "make_shared", "make_unique", "max",
                                           "min", "move", "next", "noboolalpha",
                                           "noshowbase", "noshowpos",
                                           "noskipws", "not_fn", "oct", "prev",
                                           "random_shuffle", "ref",
                                           "regex_match", "regex_replace",
                                           "regex_search", "remove", "replace",
                                           "resetiosflags", "right", "round",
                                           "scientific", "setbase", "setfill",
                                           "setiosflags", "set_new_handler",
                                           "setprecision", "setw", "showbase",
                                           "showpoint", "showpos", "skipws",
                                           "sort", "stable_sort", "swap",
                                           "transform", "unexpected", "ws",
                                           # constants
                                           "nothrow", "pi", "sqrt2", "sqrt2_v",
                                           # annotations
                                           "[[deprecated]]", "[[fallthrough]]",
                                           "[[maybe_unused]]", "[[noreturn]]",
                                           # preprocessor constants
                                           "__cplusplus"
            ];
        $langData->{classnameKeywords} = [ "class", "enum", "struct",
                                           "typename", "union"
            ];
        $langData->{eolComments} = [ "//" ];
        $langData->{brComments} = [ "/*", "*/" ];
        $langData->{backslashString} = [ "'", '"' ];
        $langData->{backslashString2} = [ "L'", "'", 'L"', '"', 'u8"', '"',
                                          'u"', '"', 'U"', '"', 'R"', '"' ];
        $langData->{directives} = [ "define", "elif", "else", "endif", "error",
                                    "if", "ifdef", "ifndef", "include", "line",
                                    "pragma", "undef", "warning" ];
        $langData->{cppIncludeString} = 1;
        if ($language eq "C++Escape")
        {
            $langData->{texEscape} = [ 'º', '', '' ];
        }
        if ($sublanguage =~ /CNI/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "BigInteger", "java", "jdouble",
                                           "JvAttachCurrentThread",
                                           "JvCreateJavaVM",
                                           "JvDetachCurrentThread",
                                           "JvNewStringLatin1", "lang", "math",
                                           "NumberFormatException", "out",
                                           "System"
                ];
        }
        if ($sublanguage =~ /CppUnit/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "CppUnit", "Test", "TestCaller",
                                           "TestFixture", "TestRunner",
                                           "TestSuite", "TextTestRunner",
                                           "CPPUNIT_ASSERT",
                                           "CPPUNIT_ASSERT_EQUAL",
                                           "CPPUNIT_ASSERT_DOUBLES_EQUAL",
                                           "CPPUNIT_ASSERT_THROW",
                                           "CPPUNIT_FAIL"
                ];
        }
        if ($sublanguage =~ /cxsc/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "AllZeros", "AllZerosErrMsg", "cxsc",
                                           "DerivType", "diam", "Inf",
                                           "interval", "intvector", "ivector",
                                           "l_interval", "l_real", "mid",
                                           "power", "real", "SetDotPrecision",
                                           "SetPrecision", "stagprec", "Sup"
                ];
        }
        if ($sublanguage =~ /doxygen/)
        {
            $langData->{eolDocComments} = [ @{$langData->{eolDocComments}},
                                            "///", "Doxygen", "tex-inline",
                                            "//!", "Doxygen", "tex-inline"
                ];
            $langData->{brDocComments} = [ @{$langData->{brDocComments}},
                                           "/**", "*/", "Doxygen",
                                           "tex-inline",
                                           "/*!", "*/", "Doxygen",
                                           "tex-inline"
                ];
        }
        if ($sublanguage =~ /JNI/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "JavaVM", "JavaVMInitArgs",
                                           "JavaVMOption", "jclass",
                                           "JDK1_1InitArgs", "jdouble", "jint",
                                           "jmethodID", "JNICALL",
                                           "JNI_CreateJavaVM", "JNIEnv",
                                           "JNIEXPORT",
                                           "JNI_GetDefaultJavaVMInitArgs",
                                           "JNI_TRUE", "JNI_VERSION_1_4"
                ];
        }
        if ($sublanguage =~ /mex/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "mexErrMsgTxt", "mexFunction",
                                           "mxArray", "mxCreateDoubleMatrix",
                                           "mxGetM", "mxGetN", "mxGetPr",
                                           "mxIsComplex", "mxIsDouble", "mxREAL"
                ];
        }
        if ($sublanguage =~ /MPI/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "COMM_WORLD", "DOUBLE", "Init",
                                           "Finalize", "MPI", "Status", "SUM"
                ];
        }
        if ($sublanguage =~ /oct/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "ColumnVector", "DEFUN_DLD",
                                           "Matrix", "octave_value",
                                           "print_usage"
                ];
        }
        if ($sublanguage =~ /OpenMP/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "barrier", "omp",
                                           "omp_get_max_threads",
                                           "omp_get_num_procs",
                                           "omp_get_num_threads",
                                           "omp_get_thread_num",
                                           "omp_set_num_threads", "parallel",
                                           "_OPENMP"
                ];
        }
        if ($sublanguage =~ /Qt/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "emit", "qApp", "QAction",
                                           "QApplication", "qBlue", "QCheckBox",
                                           "QCloseEvent", "QColor", "QColormap",
                                           "QDialog", "QDir", "QFileDialog",
                                           "QFile", "QFont", "qGreen",
                                           "QGridLayout", "QGroupBox",
                                           "QGuiApplication", "QHBox",
                                           "QHBoxLayout", "QIcon", "QImage",
                                           "QKeySequence", "QLabel",
                                           "QLCDNumber", "QLineEdit", "QList",
                                           "QMainWindow", "QMdiArea",
                                           "QMdiSubWindow", "QMenu",
                                           "QMessageBox", "QMouseEvent",
                                           "QObject", "Q_OBJECT", "qOverload",
                                           "QPainter", "QPaintEvent",
                                           "QPalette", "QPixmap", "QPopupMenu",
                                           "QPushButton", "QQmlEngine",
                                           "QQuickView", "qRed", "QRgb", "qRgb",
                                           "QSlider", "QSpinBox", "QStack",
                                           "QString", "QStyle", "Qt",
                                           "QTabWidget", "QThread", "QTime",
                                           "QTimerEvent", "QToolBar", "QUrl",
                                           "QVBox", "QVBoxLayout", "QWidget",
                                           "SIGNAL", "signals", "SLOT", "slots",
                ];
        }
        if ($sublanguage =~ /X11/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "ButtonPress", "ButtonPressMask",
                                           "Expose", "ExposureMask", "KeyPress",
                                           "KeyPressMask", "KeySym",
                                           "XDrawRectangle", "XDrawString",
                                           "XEvent", "XFlush", "XKeyEvent",
                                           "XLookupString", "XNextEvent",
                                           "XSelectInput", "XSetForeground"
                ];
        }
    }
    elsif ($language eq "Java" || $language eq "JavaEscape"
           || $language eq "JavaSH")
    {
        $langData->{primaryKeywords} = [ "abstract", "assert", "boolean",
                                         "break", "byte", "case", "catch",
                                         "char", "continue", "default", "do",
                                         "double", "else", "extends", "false",
                                         "final", "finally", "float", "for",
                                         "if", "implements", "import",
                                         "instanceof", "int", "interface",
                                         "long", "native", "new", "null",
                                         "package", "private", "protected",
                                         "public", "record", "return", "short",
                                         "static", "strictfp", "super",
                                         "switch", "synchronized", "this",
                                         "throw", "throws", "transient", "true",
                                         "try", "void", "volatile", "while",
                                         ## reserved but not used:
                                         "const", "goto"
            ];
        $langData->{secondaryKeywords} = [ ## reservierter Typname,
                                           ## kontextabhängige Schlüsselworter
                                           "non-sealed", "permits", "sealed",
                                           "var", "yield",
                                           ## Klassen
                                           "AbstractAction", "AbstractQueue",
                                           "ActionEvent", "ActionListener",
                                           "Action", "Applet",
                                           "ArithmeticException",
                                           "ArrayIndexOutOfBoundsException",
                                           "ArrayList", "Arrays",
                                           "AssertionError", "AutoCloseable",
                                           "BigInteger", "Boolean",
                                           "BorderFactory", "BorderLayout",
                                           "Box", "BoxLayout", "BufferedImage",
                                           "BufferedReader", "BufferedWriter",
                                           "ButtonGroup", "Button", "Byte",
                                           "ByteArrayInputStream",
                                           "ByteArrayOutputStream", "Calendar",
                                           "ChangeEvent", "ChangeListener",
                                           "Character", "Charset",
                                           "ChoiceFormat",
                                           "ClassNotFoundException", "Class",
                                           "Cloneable",
                                           "CloneNotSupportedException",
                                           "Collections", "Collection", "Color",
                                           "Comparable", "Component",
                                           "ConcurrentHashMap", "Condition",
                                           "Connection", "Container",
                                           "ConvolveOp", "DatagramPacket",
                                           "DatagramSocket",
                                           "DateTimeFormatter", "Date",
                                           "DecimalFormat", "Dimension",
                                           "DirectoryStream",
                                           "DirectoryIteratorException",
                                           "DocumentEvent", "DocumentListener",
                                           "Double", "DriverManager",
                                           "Enumeration", "EventObject",
                                           "Exception", "File",
                                           "FileInputStream",
                                           "FileNotFoundException",
                                           "FileOutputStream", "FileReader",
                                           "Files", "FileWriter", "Float",
                                           "Font", "Frame", "Graphics",
                                           "Graphics2D", "GridLayout",
                                           "HashMap", "HashSet", "Hashtable",
                                           "IllegalAccessException",
                                           "ImageIcon", "ImageIO",
                                           "ImageObserver", "Image",
                                           "InetAddress", "InputEvent",
                                           "InputStream", "InputStreamReader",
                                           "InstantiationException", "Integer",
                                           "InternalError",
                                           "InterruptedException",
                                           "InternalFrameAdapter",
                                           "InternalFrameEvent",
                                           "InvalidClassException",
                                           "IOException", "Iterable",
                                           "Iterator", "JApplet", "JButton",
                                           "JCheckBox", "JComponent",
                                           "JDesktopPane", "JDialog",
                                           "JEditorPane", "JFileChooser",
                                           "JFrame", "JInternalFrame", "JLabel",
                                           "JMenu", "JMenuBar", "JMenuItem",
                                           "JOptionPane", "JPanel",
                                           "JRadioButtonMenuItem",
                                           "JRadioButton", "JScrollPane",
                                           "JSlider", "JSpinner",
                                           "JTabbedPane", "JTextField",
                                           "JToolBar", "JWindow", "Kernel",
                                           "KeyEvent", "KeyStroke", "Label",
                                           "LinkedHashMap", "LinkedHashSet",
                                           "LinkedList", "List",
                                           "LocalDateTime", "Locale", "Lock",
                                           "Long", "MalformedURLException",
                                           "Map.Entry", "Map", "Math",
                                           "MessageFormat", "MouseAdapter",
                                           "MouseEvent", "MouseListener",
                                           "MouseMotionAdapter",
                                           "MouseMotionListener",
                                           "MulticastSocket",
                                           "NimbusLookAndFeel",
                                           "NotSerializableException",
                                           "NumberFormatException",
                                           "NumberFormat", "Number", "Object",
                                           "ObjectInputStream",
                                           "ObjectOutputStream",
                                           "OutputStreamWriter", "OutputStream",
                                           "Panel", "ParseException", "Path",
                                           "Paths", "Point2D.Double", "Point2D",
                                           "PrintWriter", "PropertyChangeEvent",
                                           "PropertyChangeListener",
                                           "PropertyChangeSupport",
                                           "PropertyVetoException", "Random",
                                           "ReadWriteLock", "Record",
                                           "ReentrantLock",
                                           "ReentrantReadWriteLock",
                                           "RescaleOp", "ResourceBundle",
                                           "ResultSet", "Runnable",
                                           "RuntimeException", "Scanner",
                                           "Serializable", "Set", "Short",
                                           "SimpleDateFormat", "Socket",
                                           "ServerSocket", "SpinnerNumberModel",
                                           "SQLException", "Stack", "Statement",
                                           "StrictMath", "StringBuffer",
                                           "StringBuilder", "StringTokenizer",
                                           "String", "SwingConstants",
                                           "SwingUtilities", "System", "Thread",
                                           "Throwable", "Timer", "TreeMap",
                                           "TreeSet", "UIManager",
                                           "UnknownHostException",
                                           "UnsupportedLookAndFeelException",
                                           "URL", "URLConnection", "URLEncoder",
                                           "Vector", "Void",
                                           "VetoableChangeListener",
                                           "VetoableChangeSupport", "Window",
                                           "WindowAdapter", "WindowEvent",
                                           "WindowListener",
                                           ## Annotationen
                                           "FunctionalInterface", "Override",
                                           "SuppressWarnings",
                                           ## Packages
                                           "java.applet", "java.awt.event",
                                           "java.awt.geom", "java.awt.image",
                                           "java.awt", "java.beans", "java.io",
                                           "java.lang", "java.math", "java.net",
                                           "java.nio.charset", "java.nio.file",
                                           "java.sql", "java.text",
                                           "java.time.format", "java.time",
                                           "java.util.concurrent.locks",
                                           "java.util.concurrent", "java.util",
                                           "javax.imageio",
                                           "javax.swing.plaf.nimbus",
                                           "javax.swing"
            ];
        $langData->{classnameKeywords} = [ "class", "enum", "interface" ];
        $langData->{eolComments} = [ "//" ];
        $langData->{brDocComments} = [ "/**", "*/", "Javadoc", "tex-inline" ];
        $langData->{brComments} = [ "/*", "*/" ];
        #$langData->{normalString} = [ '"""' ];
        $langData->{normalStringRec} = [ '"""', '"""' , "AllString",
                                         "tex-inline-string" ];
        $langData->{backslashString} = [ "'", '"' ];
        if ($language eq "JavaEscape")
        {
            $langData->{texEscape} = [ 'º', '', '' ];
        }
        if ($language eq "JavaSH")
        {
            $langData->{eolComments} = [ @{$langData->{eolComments}}, "#!" ];
        }
        if ($sublanguage =~ /JUnit/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "AfterAll", "AfterClass",
                                           "AfterEach", "After", "Assert",
                                           "BeforeAll", "BeforeClass",
                                           "BeforeEach", "Before", "RunWith",
                                           "Suite.SuiteClasses", "Suite",
                                           "TestCase", "TestRunner",
                                           "TestSuite", "Test",
                                           "junit.awtui", "junit.swingui",
                                           "junit.framework", "junit.textui",
                                           "org.junit.jupiter.api",
                                           "org.junit.runners",
                                           "org.junit.runner", "org.junit"
                ];
        }
        if ($sublanguage =~ /Servlet/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "HttpServlet", "HttpServletRequest",
                                           "HttpServletResponse", "HttpSession",
                                           "JspWriter", "RequestDispatcher",
                                           "ServletException", "ServletContext",
                                           ## Annotationen
                                           "WebServlet",
                                           ## Packages
                                           "javax.servlet.annotation",
                                           "javax.servlet.http",
                                           "javax.servlet.jsp", "javax.servlet"
                ];
        }
        if ($sublanguage =~ /JAXWS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "Endpoint",
                                           ## Annotationen
                                           "WebMethod", "WebService",
                                           "XmlAccessorType", "XmlAccessType",
                                           "XmlElement", "XmlRootElement",
                                           ## Packages
                                           "javax.jws",
                                           "javax.xml.bind.annotation",
                                           "javax.xml.ws"

                ];
        }
    }
    elsif ($language eq "D")
    {
        $langData->{primaryKeywords} = [ "abstract", "alias", "align", "asm",
                                         "assert", "auto", "body", "bool",
                                         "break", "byte", "case", "cast",
                                         "catch", "cdouble", "cent", "cfloat",
                                         "char", "class", "const", "continue",
                                         "creal", "dchar", "debug", "default",
                                         "delegate", "delete", "deprecated",
                                         "do", "double", "else", "enum",
                                         "export", "extern", "false", "final",
                                         "finally", "float", "for", "foreach",
                                         "foreach_reverse", "function", "goto",
                                         "idouble", "if", "ifloat", "immutable",
                                         "import", "in", "inout", "int",
                                         "interface", "invariant", "ireal",
                                         "is", "lazy", "long", "macro", "mixin",
                                         "module", "new", "nothrow", "null",
                                         "out", "override", "package", "pragma",
                                         "private", "protected", "public",
                                         "pure", "real", "ref", "return",
                                         "scope", "shared", "short", "static",
                                         "struct", "super", "switch",
                                         "synchronized", "template", "this",
                                         "throw", "true", "try", "typedef",
                                         "typeid", "typeof", "ubyte", "ucent",
                                         "uint", "ulong", "union", "unittest",
                                         "ushort", "version", "void",
                                         "volatile", "wchar", "while", "with",
                                         "__FILE__", "__FUNCTION__", "__LINE__",
                                         "__MODULE__", "__PRETTY_FUNCTION__",
                                         "__gshared", "__parameters",
                                         "__traits", "__vector"
            ];
        $langData->{secondaryKeywords} = [ "main", "string" ];
        $langData->{classnameKeywords} = [ "class" ];
        $langData->{eolComments} = [ "//" ];
        $langData->{backslashString} = [ '"' ];
    }
    elsif ($language eq "Doxygen")
    {
        $langData->{altBasic} = "docComment";
        $langData->{docKeywords} = [ "\\a", "\\author", "\\brief", "\\file",
                                     "\\f\$", "\\note", "\\param", "\@param",
                                     "\\return", "\\todo", "\\throw",
                                     "\\version"
            ];
    }
    elsif ($language eq "Javadoc")
    {
        $langData->{altBasic} = "docComment";
        $langData->{docKeywords} = [ "\@author", "\@deprecated", "\@exception",
                                     "\@param", "\@return", "\@see", "\@since",
                                     "\@throws", "\@version"
            ];
    }
    elsif ($language eq "CS")
    {
        $langData->{primaryKeywords} = [ "class", "do", "double", "else", "for",
                                         "if", "int", "new", "public", "return",
                                         "static", "using", "void", "while"
            ];
        $langData->{secondaryKeywords} = [ "Console", "Double", "Hashtable",
                                           "List", "SortedDictionary", "System"
            ];
        $langData->{classnameKeywords} = [ "class" ];
        $langData->{eolComments} = [ "//" ];
        $langData->{backslashString} = [ '"' ];
    }
    elsif ($language eq "F77")
    {
        $langData->{primaryKeywords} = [ "CHARACTER", "DATA", "DO", "CALL",
                                         "CLOSE", "COMPLEX", "CONTINUE",
                                         "DIMENSION", "DOUBLE", "ELSE", "END",
                                         "ENDIF", "EXTERNAL", "FORMAT", "GO",
                                         "IF", "IMPLICIT", "INTEGER",
                                         "INTRINSIC", "LOGICAL", "OPEN",
                                         "PARAMETER", "PRECISION", "PRINT",
                                         "READ", "REAL", "RETURN", "SAVE",
                                         "THEN", "TO", "WRITE",
            ];
        $langData->{alwaysKeywords} = [ ".AND.", ".EQ.", ".EQV.", ".FALSE.",
                                        ".GE.", ".GT.", ".LE.", ".LT.", ".NE.",
                                        ".NEQV.", ".NOT.", ".OR.", ".TRUE."
            ];
        $langData->{secondaryKeywords} = [ "ASIN", "MOD" ];
        $langData->{classnameKeywords} = [ "FUNCTION", "PROGRAM", "SUBROUTINE"
            ];
        $langData->{fortComments} = [ "*", "C", "c" ];
        $langData->{colNumComments} = [ 73 ];
        $langData->{eolComments} = [ "!" ];
        $langData->{normalString} = [ "'" ];
        $langData->{sensitive} = 0;
        if ($sublanguage =~ /BLACS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "BLACS_ABORT", "BLACS_GET",
                                           "BLACS_GRIDEXIT", "BLACS_GRIDINFO",
                                           "BLACS_GRIDINIT", "BLACS_PINFO",
                                           "BLACS_SETUP", "DGEBR2D", "DGEBS2D",
                                           "DGERV2D", "DGESD2D", "DGSUM2D",
                                           "IGEBR2D", "IGEBS2D"
                ];
        }
        if ($sublanguage =~ /BLAS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "DGEMM", "DTRSM", "DTRSV"
                ];
        }
        if ($sublanguage =~ /LAPACK/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "DGESV"
                ];
        }
        if ($sublanguage =~ /MPI/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "MPI_BCAST", "MPI_COMM_RANK",
                                           "MPI_COMM_SIZE", "MPI_COMM_WORLD",
                                           "MPI_DOUBLE_PRECISION",
                                           "MPI_FINALIZE", "MPI_INIT",
                                           "MPI_RECV", "MPI_REDUCE", "MPI_SEND",
                                           "MPI_STATUS_SIZE", "MPI_SUM"
                ];
        }
        if ($sublanguage =~ /PBLAS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "PDGEMM", "PDGER", "PDSCAL", "PDTRSM"
                ];
        }
        if ($sublanguage =~ /ScaLAPACK/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "DESCINIT", "INFOG2L", "PDELGET",
                                           "PDELSET", "PDGESV"
                ];
        }
    }
    elsif ($language eq "F90")
    {
        $langData->{primaryKeywords} = [ "action", "advance", "allocatable",
                                         "allocate", "bind", "case",
                                         "character", "data", "do", "call",
                                         "c_double", "close", "complex",
                                         "concurrent", "contains", "continue",
                                         "c_short", "cycle", "deallocate",
                                         "default", "dimension", "double",
                                         "elemental", "else", "elsewhere",
                                         "end", "endif", "exit", "external",
                                         "file", "forall", "format", "go", "if",
                                         "implicit", "in", "inout", "integer",
                                         "intent", "interface", "intrinsic",
                                         "iostat", "iso_c_binding", "kind",
                                         "len", "logical", "module", "name",
                                         "none", "open", "optional", "out",
                                         "parameter", "precision", "present",
                                         "print", "public", "pure", "read",
                                         "real", "recursive", "result",
                                         "return", "save", "select", "size",
                                         "status", "then", "to", "type", "unit",
                                         "use", "value", "where", "while",
                                         "write",
            ];
        $langData->{alwaysKeywords} = [ ".and.", ".eq.", ".eqv.", ".false.",
                                        ".ge.", ".gt.", ".le.", ".lt.", ".ne.",
                                        ".neqv.", ".not.", ".or.", ".true.",
                                        "&"
            ];
        $langData->{secondaryKeywords} = [ "asin", "dble", "int", "matmul",
                                           "mod", "reshape", "sin", "sqrt",
                                           "transpose"
            ];
        $langData->{classnameKeywords} = [ "function", "module", "program",
                                           "subroutine", "type"
            ];
        $langData->{eolComments} = [ "!" ];
        $langData->{normalString} = [ "'", '"' ];
        $langData->{sensitive} = 0;
        if ($sublanguage =~ /BLACS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "blacs_abort", "blacs_exit",
                                           "blacs_get", "blacs_gridexit",
                                           "blacs_gridinfo", "blacs_gridinit",
                                           "blacs_pinfo", "blacs_setup",
                                           "dgebr2d", "dgebs2d", "dgerv2d",
                                           "dgesd2d", "dgsum2d", "igebr2d",
                                           "igebs2d"
                ];
        }
        if ($sublanguage =~ /BLAS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "dgemm", "dtrsm", "dtrsv"
                ];
        }
        if ($sublanguage =~ /LAPACK/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "dgesv"
                ];
        }
        if ($sublanguage =~ /MPI/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "mpi_bcast", "mpi_comm_rank",
                                           "mpi_comm_size", "mpi_comm_world",
                                           "mpi_double_precision",
                                           "mpi_finalize", "mpi_init",
                                           "mpi_recv", "mpi_reduce", "mpi_send",
                                           "mpi_status_size", "MPI_SUM"
                ];
        }
        if ($sublanguage =~ /PBLAS/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "pdgemm", "pdger", "pdscal", "pdtrsm"
                ];
        }
        if ($sublanguage =~ /ScaLAPACK/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "descinit", "infog2l", "numroc",
                                           "pdelget", "pdelset", "pdgesv"
                ];
        }
    }
    elsif ($language eq "Pascal")
    {
        $langData->{primaryKeywords} = [ "array", "begin", "do", "double",
                                         "else", "end", "for", "function", "if",
                                         "integer", "longint", "of", "or",
                                         "mod", "procedure", "program",
                                         "repeat", "then", "to", "until",
                                         "uses", "var", "while",
                                         # in fact Delphi
                                         "result"
            ];
        $langData->{classnameKeywords} = [ "function", "procedure", "program" ];
        $langData->{secondaryKeywords} = [ "dec", "read", "setlength", "write",
                                           "writeln"
            ];
        $langData->{brComments} = [ "{", "}" ];
        $langData->{backslashString} = [ "'" ];
        $langData->{sensitive} = 0;
    }
    elsif ($language eq "Basic")
    {
        $langData->{primaryKeywords} = [ "AddHandler", "AddressOf", "Alias",
                                         "And", "AndAlso", "As", "Boolean",
                                         "ByRef", "Byte", "ByVal", "Call",
                                         "Case", "Catch", "CBool", "CByte",
                                         "CChar", "CDate", "CDec", "CDbl",
                                         "Char", "CInt", "Class", "CLng",
                                         "CObj", "Const", "Continue", "CSByte",
                                         "CShort", "CSng", "CStr", "CType",
                                         "CUInt", "CULng", "CUShort", "Date",
                                         "Decimal", "Declare", "Default",
                                         "Delegate", "Dim", "DirectCast", "Do",
                                         "Double", "Each", "Else", "ElseIf",
                                         "End", "EndIf", "Enum", "Erase",
                                         "Error", "Event", "Exit", "False",
                                         "Finally", "For", "Friend", "Function",
                                         "Get", "GetType", "Global", "GoSub",
                                         "GoTo", "Handles", "If", "Implements",
                                         "Imports", "In", "Inherits", "Integer",
                                         "Interface", "Is", "IsNot", "Let",
                                         "Lib", "Like", "Long", "Loop", "Me",
                                         "Mod", "Module", "MustInherit",
                                         "MustOverride", "MyBase", "MyClass",
                                         "Namespace", "Narrowing", "New",
                                         "Next", "Not", "Nothing",
                                         "NotInheritable", "NotOverridable",
                                         "Object", "Of", "On", "Operator",
                                         "Option", "Optional", "Or", "OrElse",
                                         "Overloads", "Overridable",
                                         "Overrides", "ParamArray", "Partial",
                                         "Private", "Property", "Protected",
                                         "Public", "RaiseEvent", "ReadOnly",
                                         "ReDim", "REM", "RemoveHandler",
                                         "Resume", "Return", "Sbyte", "Select",
                                         "Set", "Shadows", "Shared", "Short",
                                         "Single", "Static", "Step", "Stop",
                                         "String", "Structure", "Sub",
                                         "SyncLock", "Then", "Throw", "To",
                                         "True", "Try", "TryCast", "TypeOf",
                                         "Variant", "Wend", "UInteger", "ULong",
                                         "UShort", "Using", "When", "While",
                                         "Widening", "With", "WithEvents",
                                         "WriteOnly", "Xor"
            ];
        $langData->{secondaryKeywords} = [ "Console", "System" ];
        $langData->{classnameKeywords} = [ "Function", "Class", "Structure",
                                           "Sub" ];
        $langData->{eolComments} = [ "'" ];
        $langData->{backslashString} = [ '"' ];
    }
    elsif ($language eq "Perl")
    {
        $langData->{primaryKeywords} = [ "and", "bless", "continue", "die",
                                         "do", "else", "elsif", "eval", "exit",
                                         "for", "foreach", "if", "last", "my",
                                         "next", "no", "not", "or", "our",
                                         "redo", "return", "undef", "unless",
                                         "until", "use", "while", "xor",
                                         "cmp", "eq", "ge", "gt", "le", "lt",
                                         "ne"
            ];
        $langData->{secondaryKeywords} = [ "chomp", "close", "defined",
                                           "delete", "hex", "join", "keys",
                                           "open", "pack", "print", "printf",
                                           "push", "read", "reverse", "seek",
                                           "split", "substr", "values",
                                           "STDERR", "STDIN", "STDOUT", "\@ISA",
                                           "SUPER"
            ];
        $langData->{classnameKeywords} = [ "package", "sub" ];
        $langData->{perlEolComments} = [ "#" ];
        $langData->{backslashString} = [ "'", '"' ];
    }
    elsif ($language eq "Python" || $language eq "PythonEscape")
    {
        $langData->{primaryKeywords} = [ "and", "as", "assert", "break",
                                         "class", "continue", "def", "del",
                                         "elif", "else", "except", "False",
                                         "finally", "for", "from", "global",
                                         "if", "import", "in", "is", "lambda",
                                         "None", "nonlocal", "not", "or",
                                         "pass", "raise", "return", "True",
                                         "try", "while", "with", "yield"
            ];
        $langData->{secondaryKeywords} = [ "BaseException", "Exception",
                                           "Fraction", "IOError", "NameError",
                                           "OverflowError", "ValueError",
                                           "ZeroDivisionError",
                                           "abs", "bool", "complex", "dict",
                                           "exit", "float", "frozenset", "int",
                                           "input", "isinstance", "len", "list",
                                           "open", "print", "range", "repr",
                                           "set", "str", "super", "tuple",
                                           "type",
                                           "copy", "math", "os", "random", "re",
                                           "subprocess", "sys", "time",
                                           "tkinter", "unittest",
                                           '@classmethod', '@staticmethod'
            ];
        $langData->{classnameKeywords} = [ "class", "def" ];
        $langData->{eolComments} = [ "#" ];
        $langData->{backslashString2} = [ "r'", "'" ];
        $langData->{backslashString} = [ "'", '"' ];
        if ($language eq "PythonEscape")
        {
            $langData->{texEscape} = [ 'º', '', '' ];
        }
    }
    elsif ($language eq "Bash" || $language eq "BashEscape")
    {
        $langData->{primaryKeywords} = [ "break", "case", "do", "done", "elif",
                                         "else", "esac", "fi", "for", "if",
                                         "in", "select", "then", "until",
                                         "while",
                                         '$1', '$2', '$3', '$3', '$4', '$5',
                                         '$6', '$7', '$8', '$9', '$0', '$#',
                                         '$*', '$$', '$@' ];
        $langData->{secondaryKeywords} = [ "alias", "bash", "bg", "bind",
                                           "cd", "command", "compgen",
                                           "complete", "declare", "dirs",
                                           "disown", "echo", "enable", "eval",
                                           "exec", "exit", "export", "fc", "fg",
                                           "getopts", "hash", "help", "history",
                                           "jobs", "kill", "let", "local",
                                           "logout", "popd", "printf", "pushd",
                                           "pwd", "read", "readonly", "return",
                                           "set", "shift", "shopt", "source",
                                           "suspend", "test", "times", "trap",
                                           "type", "typeset", "ulimit", "umask",
                                           "unalias", "unset", "wait"
            ];
        $langData->{classnameKeywords} = [ "function" ];
        $langData->{alsoLetters} = "[/.]";
        $langData->{eolComments} = [ "#" ];
        $langData->{backslashString} = [ "'", '"' ];
        #$langData->{literate} = [ '`', '̀' ];
        if ($language eq "BashEscape")
        {
            $langData->{texEscape} = [ '°', '\mdseries\itshape{}', '', 'º',
                                       '\mdseries\itshape{}', '' ];
        }
    }
    elsif ($language eq "Matlab")
    {
        $langData->{primaryKeywords} = [ "break", "case", "catch", "classdef",
                                         "continue", "else", "elseif", "end",
                                         "for", "function", "global", "if",
                                         "import", "methods", "otherwise",
                                         "parfor", "persistent", "properties",
                                         "return", "spmd", "switch", "try",
                                         "while"
            ];
        $langData->{secondaryKeywords} = [ "Access", "all", "ans", "any",
                                           "atan2", "axis", "bar", "bicgstab",
                                           "char", "chol", "class", "clear",
                                           "clock", "colormap", "conj", "cos",
                                           "diag", "disp", "display", "doc",
                                           "double", "eig", "error", "exit",
                                           "eye", "false", "figure", "fft",
                                           "fft2", "fix", "format", "fprintf",
                                           "fscanf", "get", "GetAccess",
                                           "gmres", "handle", "help", "hold",
                                           "hist", "histc", "i", "ifft",
                                           "imread", "inf", "input",
                                           "inputname", "int16", "int32",
                                           "int64",  "int8", "inv", "isa", "j",
                                           "load", "loglog", "lu", "matlabpool",
                                           "max", "meshgrid", "minres", "min",
                                           "mod", "mtimes", "nargin", "nargout",
                                           "norm", "num2str", "ode15s", "ode45",
                                           "ones", "pcg", "pi", "plot", "plot3",
                                           "plus", "print", "private", "prod",
                                           "public", "qmr", "qr", "rat",
                                           "repmat", "reshape", "quit", "rand",
                                           "randperm", "real", "rng", "save",
                                           "semilogx", "semilogy", "set",
                                           "SetAccess", "shading", "sin",
                                           "single", "size", "sort", "sqrt",
                                           "str2num", "strcmp", "subplot",
                                           "subsref", "subsasgn", "sum", "surf",
                                           "tic", "title", "toc", "transpose",
                                           "true", "uint16", "uint8", "who",
                                           "whos", "xor", "zeros",
                                           "sfnew", "simulink", "sim",
                                           "stateflow"
            ];
        $langData->{eolComments} = [ "%" ];
        $langData->{matlabString} = [ "'" ];
        if ($sublanguage =~ /Intlab/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "infsup", "intval"
                ];
        }
    }
    elsif ($language eq "Stateflow")
    {
        $langData->{primaryKeywords} = [ "after", "at", "before", "during",
                                         "entry", "every", "exit", "in", "on"
            ];
        $langData->{secondaryKeywords} = [ "matlab", "ml", "t"
            ];
        $langData->{eolComments} = [ "%" ];
    }
    elsif ($language eq "Octave")
    {
        $langData->{primaryKeywords} = [ "break", "catch", "do", "else",
                                         "elseif", "end", "endfor",
                                         "endfunction", "endif", "endswitch",
                                         "endwhile", "end_try_catch", "for",
                                         "function", "if", "try", "until",
                                         "while"
            ];
        $langData->{secondaryKeywords} = [ "append", "argv", "bar", "ceil",
                                           "disp", "error", "false", "figure",
                                           "fix", "fork", "fprintf", "getpwent",
                                           "help", "hist", "index", "input",
                                           "length", "list", "mod", "norm",
                                           "nth", "pause", "popen", "printf",
                                           "prod", "rand", "rem", "reshape",
                                           "scanf", "strcmp", "symlink", "tic",
                                           "title", "toc", "true"
            ];
        $langData->{eolComments} = [ "%", "#" ];
        $langData->{backslashString} = [ '"' ];
        $langData->{matlabString} = [ "'" ];
    }
    elsif ($language eq "Prolog" || $language eq "PrologEscape")
    {
        $langData->{primaryKeywords} = [ "arithmetic_function", "atom",
                                         "consult", "halt", "integer", "is",
                                         "module", "use_module", "!"
            ];
        $langData->{secondaryKeywords} = [ "initialization", "mod", "prompt1",
                                           "read", "write", "writef"
            ];
        $langData->{eolComments} = [ "%" ];
        $langData->{fortComments} = [ "#!" ];
        $langData->{brComments} = [ "/*", "*/" ];
        $langData->{backslashString} = [ "'", '"' ];
        if ($language eq "PrologEscape")
        {
            $langData->{texEscape} = [ 'º', '', '' ];
        }
    }
    elsif ($language eq "Lisp" || $language eq "LispEscape")
    {
        $langData->{primaryKeywords} = [ "defun", "do", "for", "from", "if",
                                         "let", "loop", "progn", "return",
                                         "to", "when", "while"
            ];
        $langData->{secondaryKeywords} = [ "car", "cdr", "format", "load",
                                           "mod", "nil", "null", "print",
                                           "push", "read", "setq"
            ];
        $langData->{eolComments} = [ ";" ];
        $langData->{fortComments} = [ "#!" ];
        $langData->{backslashString} = [ '"' ];
        if ($language eq "LispEscape")
        {
            $langData->{texEscape} = [ 'º', '', '' ];
        }
    }
    elsif ($language eq "Make")
    {
        $langData->{primaryKeywords} = [ "else", "endif", "export", "ifeq",
                                         "include",
                                         '$<', '$^', '$@', '$*', '@D', '@F'
            ];
        $langData->{secondaryKeywords} = [ "dir", "error", "notdir", "patsubst",
                                           "shell", "wildcard"
            ];
        $langData->{alsoLetters} = "[/.]";
        $langData->{eolComments} = [ "#" ];
        $langData->{showTabs} = 1;
        $langData->{literate} = [ "<<t>>",
                                  "º\\makebox[11ex][l]{\$\\hookrightarrow\$}º"
            ];
        $langData->{texEscape} = [ 'º', '', '' ];
    }
    elsif ($language eq "autoconf")
    {
        $langData->{primaryKeywords} = [ "AC_ARG_WITH", "AC_CHECK_FUNCS",
                                         "AC_CHECK_HEADERS", "AC_CHECK_LIB",
                                         "AC_CONFIG_FILES", "AC_CONFIG_HEADER",
                                         "AC_CONFIG_HEADERS", "AC_DEFINE",
                                         "AC_EGREP_HEADER", "AC_HEADER_TIME",
                                         "AC_CONFIG_SRCDIR", "AC_INIT",
                                         "AC_OUTPUT", "AC_PREREQ", "AC_PROG_CC",
                                         "AM_INIT_AUTOMAKE"
            ];
        $langData->{eolComments} = [ "#" ];
    }
    elsif ($language eq "SQL")
    {
        $langData->{primaryKeywords} = [ "ALL", "CREATE", "DATABASE", "DELETE",
                                         "DESCRIBE", "DOUBLE", "DROP", "EXISTS",
                                         "FROM", "GRANT", "INSERT", "IF",
                                         "INTEGER", "INTO", "KEY", "NOT",
                                         "NULL", "ON", "PRIMARY", "SELECT",
                                         "SHOW", "TABLE", "TABLES", "TO",
                                         "UPDATE", "USE", "VALUES", "VARCHAR",
                                         "WHERE"
            ];
        $langData->{eolComments} = [ "--" ];
        $langData->{normalString} = [ "'" ];
        $langData->{sensitive} = 0;
    }
    elsif ($language eq "HTML")
    {
        $langData->{primaryKeywords} = [ "a", "applet", "body", "br", "doctype",
                                         "form", "head", "html", "img", "input",
                                         "meta", "object", "p", "param",
                                         "table", "td", "title", "tr"
            ];
        $langData->{alwaysKeywords} = [ ">", "</", "<", "/>", "&gt;", "&lt;",
                                        "&quot;" ];
        $langData->{secondaryKeywords} = [ "action", "align", "archive",
                                           "classid", "code", "codetype",
                                           "colspan", "content", "height",
                                           "http-equiv", "name",  "type",
                                           "value", "width"
            ];
        $langData->{brComments} = [ "<!--", "-->" ];
        $langData->{normalString} = [ '"', "'" ];
        $langData->{sensitive} = 0;
        if ($sublanguage =~ "JSP")
        {
            $langData->{extraKeywords} = [ "jsp:getProperty", "jsp:setProperty",
                                           "jsp:useBean"
                ];
            $langData->{secondaryKeywords} = [ @{$langData->{secondaryKeywords}},
                                               "class", "id", "property" ];
            $langData->{brComments} = [ @{$langData->{brComments}},
                                        "<%--", "--%>", "<% /**", "**/ %>"
                ];
            $langData->{normalStringRec} = [ "<%!", "%>" , "Java\@Servlet",
                                             "tex-inline",
                                             "<%=", "%>" , "Java\@Servlet",
                                             "tex-inline",
                                             "<%@", "%>" , "HTML\@JSPDirective",
                                             "tex-inline",
                                             "<%", "%>" , "Java\@Servlet",
                                             "tex-inline",
                                             '${', "}", "EL", "tex-inline"
                ];
        }
        if ($sublanguage =~ "JSPDirective")
        {
            $langData->{extraKeywords} = [ "page" ];
        }
    }
    elsif ($language eq "xml")
    {
        $langData->{primaryKeywords} = [ ];
        $langData->{alwaysKeywords} = [ ">", "</", "<", "/>" ];
        $langData->{brComments} = [ "<!--", "-->" ];
        $langData->{normalString} = [ '"', "'" ];
        if ($sublanguage =~ /Ant/)
        {
            $langData->{extraKeywords} = [ @{$langData->{extraKeywords}},
                                           "delete", "jar", "javac", "mkdir",
                                           "project", "property", "target"
                ];
        }
    }
    elsif ($language eq "QML")
    {
        $langData->{primaryKeywords} = [ "import" ];
        $langData->{extraKeywords} = [ "MouseArea", "Rectangle", "Text" ];
        $langData->{normalString} = [ '"' ];
        $langData->{eolComments} = [ "//" ];
    }
    elsif ($language eq "EL")
    {
        $langData->{primaryKeywords} = [ "gt" ];
        $langData->{secondaryKeywords} = [ "param" ];
        $langData->{normalString} = [ '"', "'" ];
    }
    elsif ($language =~ /latex/)
    {
        $langData->{primaryKeywords} = [ '\\begin', '\\chapter',
                                         '\\documentclass', '\\emph', '\\end',
                                         '\\input', '\\label', '\\left',
                                         '\\newcommand', '\\newtheorem',
                                         '\\right', '\\section', '\\setlength',
                                         '\\usepackage', '\\\\'
            ];
        $langData->{alwaysKeywords} = [ '\\{', '\\}' ];
        $langData->{secondaryKeywords} = [ '\\alpha', '\\deg', '\\ge', '\\int',
                                           '\\in', '\\itshape', '\\ldots',
                                           '\\omega', '\\overline',
                                           '\\parindent', '\\partial', '\\pi',
                                           '\\sigma', '\\text', '\\times',
                                           '\\unichar'
            ];
        $langData->{classnameKeywords} = [ '\\begin', '\\end' ];
        $langData->{eolComments} = [ "%" ];
        $langData->{normalStringRec} = [ '\\[', '\\]' , "latex-math",
                                         "tex-inline-string",
                                         '$', '$' , "latex-math",
                                         "tex-inline-string"
            ];
        if ($language eq "latex-math")
        {
            $langData->{altBasic} = "string";
        }
    }
    elsif ($language eq "Mathematica")
    {
        $langData->{primaryKeywords} = [ "Break", "For", "If", "Module",
                                         "Return", "While"
            ];
        $langData->{secondaryKeywords} = [ "Abort", "Abs", "ArcSin", "Arg",
                                           "ChebyshevT", "Clear", "Conjugate",
                                           "Cos", "DSolve", "E", "Exit", "Exp",
                                           "False", "FindRoot", "FullSimplify", "I", "Im",
                                           "Infinity", "Input", "IntegerQ",
                                           "ListPlot", "Log", "MatrixForm",
                                           "Max", "Mod", "N","NIntegrate",
                                           "NProduct", "NSolve", "NSum",
                                           "ParametricPlot", "ParametricPlot3D",
                                           "Pi", "Plot", "Plot3D", "Print",
                                           "Quit", "Random", "Re", "Round",
                                           "Sin", "Solve", "Sqrt", "True"
            ];
        $langData->{brComments} = [ "(*", "*)" ];
        $langData->{normalString} = [ '"' ];
    }
    elsif ($language eq "Interactive" || $language eq "InteractiveEscape")
    {
        $langData->{interactive} = [ "§", "§" ];
        $langData->{texEscape} = [ 'þ',
                                   #'\rule[-\spDepth-0.75mm]{0pt}{\spHeight+\spDepth+1.5mm}\renewcommand{\mathcol}{}$\displaystyle\mathtt{}',
                                   '\rule[-\spDepth-0.75mm]{0pt}{\spHeight+\spDepth+1.5mm}$\displaystyle\mathtt{}',
                                   '$'
            ];
        if ($language eq "InteractiveEscape")
        {
            $langData->{texEscape} = [ @{$langData->{texEscape}},
                                       'º', '', '' ];
        }
    }
    elsif ($language eq "EBNF")
    {
        $langData->{brComments} = [ "(*", "*)" ];
        $langData->{normalString} = [ '"', "'" ];
        $langData->{alwaysKeywords} = [ "(", ")", "[", "]", "{", "}", "|" ];
        $langData->{extraLineskip} = 1;
    }
    elsif ($language eq "Algorithm")
    {
        $langData->{primaryKeywords} = [ "algorithm", "case", "input", "output",
                                         "continue", "do", "else", "error",
                                         "for", "if", "return", "stop", "then",
                                         "while",
                                         "Algorithmus", "Ausgabe", "auswählen",
                                         "Eingabe", "Fehler", "bis", "dann",
                                         "falls", "für", "solange", "sonst",
                                         "wenn", "wiederhole"
            ];
        $langData->{secondaryKeywords} = [ "false", "true",
                                           "falsch", "null", "wahr" ];
        $langData->{classnameKeywords} = [ "function" ];
        $langData->{eolCommentsRec} = [ "//", "Alg-comment",
                                        "tex-inline-comment"
            ];
        $langData->{brCommentsRec} = [ "/*", "*/" , "Alg-comment",
                                       "tex-inline-comment",
                                       "{", "}", "Alg-comment",
                                       "tex-inline-comment"
            ];
        $langData->{normalStringRec} = [ '``', "''" , "Alg-string",
                                         "tex-inline-string", '“', '”' ,
                                         "Alg-string", "tex-inline-string", '„',
                                         '“' , "Alg-string", "tex-inline-string"
            ];
        $langData->{manualEmph} = [ "§", "§" ];
        $langData->{noKeyword} = [ "º", "º" ];
        $langData->{texEscape} = [ '$',
                                   #'\scalebox{1.17}[1]{\renewcommand{\mathcol}{}$', '$}',
                                   '\scalebox{1.17}[1]{$', '$}',
                                   '@',
                                   '\scalebox{1.17}[1]{\ifthenelse{\boolean{mmode}}{}{\sffamily\mdseries}',
                                   '}'
            ];
        $langData->{extraLineskip} = 1;
        $langData->{literate} = [ '°', '@\hspace*{1ex}@', ':=', '$\;:=\;$',
                                  '->', '$\shortrightarrow$', '∘GRAD∘', '°'
            ];
    }
    elsif ($language =~ /Alg-(comment|string)/)
    {
        $langData->{texEscape} = [ '$',
                                   #'\scalebox{1.25}[1]{\renewcommand{\mathcol}{}$', '$}',
                                   '\scalebox{1.25}[1]{$', '$}',
                                   '@',
                                   '\scalebox{1.25}[1]{\ifthenelse{\boolean{mmode}}{}{\sffamily\mdseries}',
                                   '}'
            ];
        $langData->{literateEval} = [ 'text\{(.*?)}',
                                      'scalebox{0.8}[1]{\\\\text{$1}}'
            ];
        if ($language =~ /Alg-comment/)
        {
            $langData->{altBasic} = "comment";
        }
        elsif ($language =~ /Alg-string/)
        {
            $langData->{altBasic} = "string";
        }
    }
    elsif ($language eq "AllComment")
    {
        $langData->{altBasic} = "comment";
    }
    elsif ($language eq "AllString" || $language eq "AllStringEscape")
    {
        $langData->{altBasic} = "string";
        if ($language eq "AllStringEscape")
        {
            $langData->{texEscape} = [ 'º', '', '' ];
        }
    }
    elsif ($language eq "AllDirective")
    {
        $langData->{altBasic} = "directive";
    }
    elsif ($language eq "AllDocKeyword")
    {
        $langData->{altBasic} = "docKeyword";
    }
}
