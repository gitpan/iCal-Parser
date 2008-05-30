# -*-cperl -*-
# $Id: 02parse.t 464 2008-05-30 23:49:01Z rick $
use Test::More;
use iCal::Parser;

require "t/Defrost.pm";

my @files=glob("t/calendars/[0-9]*.ics");
plan tests => scalar @files + 3;

my $tz='UTC';
my $VAR1;
foreach my $f (@files) {
    my $h = iCal::Parser->new(start=>'20040101',tz=>$tz)->parse($f);
    if($ENV{_DUMP}) {ice("$f.dump", $h);}
    $VAR1=defrost("$f.dump");
    is_deeply($h,$VAR1,$f=~/.+\d+(.+)\.ics/);
}
$VAR1= defrost("t/calendars/10multi-cal.ics.dump");
my @cals=("t/calendars/02event-duration.ics",
	  "t/calendars/03all-day-event.ics");

my $h=iCal::Parser->new(start=>'20040101',tz=>$tz)->parse(@cals);
is_deeply($h,$VAR1,"multiple calendars (parse)");

$h=iCal::Parser->new(start=>'20040101',tz=>$tz)->parse_files(@cals);
is_deeply($h,$VAR1,"multiple calendars (parse_files)");

my @s=();
{
    local $/='';
    my $i=0;
    foreach my $c (@cals) {
	$VAR1->{cals}[$i]{'X-WR-CALNAME'}='Calendar ' . ($i+1);
	++$i;
	open IN, "<$c" or die "Can't open $c, $!";
	push @s, scalar <IN>;
	close IN;
    }
}
#must do outside of block above as $/ affect IO::String
$h=iCal::Parser->new(start=>'20040101',tz=>$tz)->parse_strings(@s);
is_deeply($h,$VAR1,"multiple calendars (parse_strings)");

