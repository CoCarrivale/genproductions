#!/usr/bin/perl

# Make fixed format from YODA1 file

$workdir = ".";
$of = $ARGV[0];

@vars = ("m4l","m3l","mpp","mee","pt4l","ptpp","ptee","ptep","ptmm","yep","ymm","yee","dyee","dypp","dyez","dphiee","dphipp","dree","drpp","cthep","cthmm","cscatt","cosee","cospp");

# Order in yoda file: ("[MUR=2.0_]","[MUR=0.5_]","[MUF=2.0_]","[MUR=2.0_MUF=2.0_]","[MUF=0.5_]","[MUR=0.5_MUF=0.5_]")
# Final order should be: ("[MUR=0.5_MUF=0.5_]","[MUR=0.5_]","[MUF=0.5_]","[NOMINAL]","[MUF=2.0_]","[MUR=2.0_]","[MUR=2.0_MUF=2.0_]");

open(FH, '>', $of) or die "ciao";;
    
foreach $var (@vars) {
    
    my @nominal = ();  my $isnominal = 0;
    my @mur2 = ();  my $ismur2 = 0;
    my @mur05 = ();  my $ismur05 = 0;
    my @muf2 = ();  my $ismuf2 = 0;
    my @murmuf2 = ();  my $ismurmuf2 = 0;
    my @muf05 = ();  my $ismuf05 = 0;
    my @murmuf05 = ();  my $ismurmuf05 = 0;
    
    print FH "#" . $var . "\n";
	
    # retrieve yoda file
    open(INFILE,"out.yoda") or die "cannot open YODA file";;
    @log=<INFILE>;
    close(INFILE);

    # create the seven subfiles with single histograms
    foreach $line (@log) {
	if ($line =~ m/(${var})/ && $line =~ /BEGIN YODA/ && !($line =~ /RAW/) && !($line =~ /\[/)) {$isnominal = 1;}
	if ($isnominal == 1 && $line =~ /END YODA/) {$isnominal = 0;}
	if ($line =~ m/(${var})/ && $line =~ /BEGIN YODA/ && !($line =~ /RAW/) && $line =~ /\[MUR=2.0_\]/) {$ismur2 = 1;}
	if ($ismur2 == 1 && $line =~ /END YODA/) {$ismur2 = 0;}
	if ($line =~ m/(${var})/ && $line =~ /BEGIN YODA/ && !($line =~ /RAW/) && $line =~ /\[MUR=0.5_\]/) {$ismur05 = 1;}
	if ($ismur05 == 1 && $line =~ /END YODA/) {$ismur05 = 0;}
	if ($line =~ m/(${var})/ && $line =~ /BEGIN YODA/ && !($line =~ /RAW/) && $line =~ /\[MUF=2.0_\]/) {$ismuf2 = 1;}
	if ($ismuf2 == 1 && $line =~ /END YODA/) {$ismuf2 = 0;}
	if ($line =~ m/(${var})/ && $line =~ /BEGIN YODA/ && !($line =~ /RAW/) && $line =~ /\[MUR=2.0_MUF=2.0_\]/) {$ismurmuf2 = 1;}
	if ($ismurmuf2 == 1 && $line =~ /END YODA/) {$ismurmuf2 = 0;}
	if ($line =~ m/(${var})/ && $line =~ /BEGIN YODA/ && !($line =~ /RAW/) && $line =~ /\[MUF=0.5_\]/) {$ismuf05 = 1;}
	if ($ismuf05 == 1 && $line =~ /END YODA/) {$ismuf05 = 0;}
	if ($line =~ m/(${var})/ && $line =~ /BEGIN YODA/ && !($line =~ /RAW/) && $line =~ /\[MUR=0.5_MUF=0.5_\]/) {$ismurmuf05 = 1;}
	if ($ismurmuf05 == 1 && $line =~ /END YODA/) {$ismurmuf05 = 0;}

	if ($isnominal) {push(@nominal,$line);}
	if ($ismur2) {push(@mur2,$line);}
	if ($ismur05) {push(@mur05,$line);}
	if ($ismuf2) {push(@muf2,$line);}
	if ($ismurmuf2) {push(@murmuf2,$line);}
	if ($ismuf05) {push(@muf05,$line);}
	if ($ismurmuf05) {push(@murmuf05,$line);}
    }

    my $ientry = 0;
    foreach $entry (@nominal) {
	if ($entry =~ /000/ && !($entry =~ /Total/) && !($entry =~ /flow/) && !($entry =~ /ScaledBy/)) {
	    @splitentry = split('\t', $entry);
	    print FH $splitentry[0] . "\t" . $splitentry[1] . "\t" . $splitentry[2] . "\t" .  $splitentry[3] . "\t";
	    @splitmurmuf05 = split('\t', $murmuf05[$ientry]);
	    print FH $splitmurmuf05[2] . "\t";
	    @splitmur05 = split('\t', $mur05[$ientry]);
	    print FH $splitmur05[2] . "\t";
	    @splitmuf05 = split('\t', $muf05[$ientry]);
	    print FH $splitmuf05[2] . "\t" . $splitentry[2] . "\t";
	    @splitmuf2 = split('\t', $muf2[$ientry]);
	    print FH $splitmuf2[2] . "\t";
	    @splitmur2 = split('\t', $mur2[$ientry]);
	    print FH $splitmur2[2] . "\t";
	    @splitmurmuf2 = split('\t', $murmuf2[$ientry]);
	    print FH $splitmurmuf2[2] . "\n";
	}
	$ientry +=1;
    }	
    print FH "\n"
	
}

close($of);
print "Done conversion! Bye bye. \n";
 
