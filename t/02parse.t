use Test::More;
use iCal::Parser;

my @files=glob("t/calendars/[0-9]*.ics");
plan tests => scalar @files + 1;

foreach my $f (@files) {
    require "$f.dump";
    my $h = iCal::Parser->new->parse($f);
    is_deeply($h,$VAR1,$f=~/.+\d+(.+)\.ics/);
}
require "t/calendars/10multi-cal.ics.dump";
my $h=iCal::Parser->new->parse("t/calendars/02event-duration.ics",
			       "t/calendars/03all-day-event.ics");
is_deeply($h,$VAR1,"multiple calendars");
