# $Id: Defrost.pm 37 2005-03-29 00:58:22Z rick $
use FreezeThaw qw(thaw);

sub defrost {
    my $f=shift;
    local $/=undef;
    open IN, "<$f" or die "Can't open $f, $!";
    my $s=<IN>;
    close IN;
    return (thaw($s))[0];
}
1;
