# $Id: Defrost.pm,v 1.1 2005/02/08 19:45:12 rick Exp $
use FreezeThaw qw(thaw);

sub defrost {
    my $f=shift;
    local $/=undef;
    open IN, "<$f" or die "Can't open $f.dump, $!";
    my $s=<IN>;
    close IN;
    return (thaw($s))[0];
}
1;
