use Test::More tests => 7;
use iCal::Parser;
use DateTime;
use DateTime::Span;


my $start=DateTime->new(year=>2004,month=>12,day=>01);
my $end=DateTime->new(year=>2005,month=>12,day=>01);
my $span=DateTime::Span->new(start=>$start, end=>$end);
my $h;
require "t/calendars/t-start.ics.dump";
$h=iCal::Parser->new(start=>'20041201')->parse('t/calendars/t.ics');
is_deeply($h,$VAR1,"start");

$h=iCal::Parser->new(start=>$start)->parse('t/calendars/t.ics');
is_deeply($h,$VAR1,"start as datetime");

require "t/calendars/t-end.ics.dump";
$h=iCal::Parser->new(end=>$end)->parse('t/calendars/t.ics');
is_deeply($h,$VAR1,"end as datetime");

require "t/calendars/t-start-end.ics.dump";
$h=iCal::Parser->new(start=>'20041201',end=>'20051201')
->parse('t/calendars/t.ics');
is_deeply($h,$VAR1,"start and end");

$h=iCal::Parser->new(start=>$start,end=>$end)
->parse('t/calendars/t.ics');
is_deeply($h,$VAR1,"start and end as datetimes");

$h=iCal::Parser->new(span=>$span)->parse('t/calendars/t.ics');
is_deeply($h,$VAR1,"span");

require "t/calendars/t-months.ics.dump";
$h=iCal::Parser->new(months=>14)->parse('t/calendars/t.ics');
is_deeply($h,$VAR1,"months");
