use strict;
use Irssi;

my $ltime = time;

my %szotar = (
);
my $lastreload = 0;

sub reload {
    %szotar = ();
    system("cd ~/hejesirssi; git pull >/dev/null 2>&1");
    open my $in, '<', '/home/web/hejesirssi/lista.dat' or print "Can't read file: $!";
    my $i = 0;
    while (<$in>) {
        m/^(.*) => (.*)$/;
        $szotar{$1} = $2;
        $i++;
    }
    $lastreload = time;
    # print "$i word pair loaded.\n";
}

reload();

sub event_pub {
	my ($server, $data, $nick, $address) = @_;
	Irssi::signal_continue($server, $data, $nick, $address);
	my ($target, $msg) = split(/ :/, $data, 2);
	my $ctime = time;

	return if ($ctime - $ltime < 2);

	$msg =~ s/\x03\d?\d?(,\d?\d?)?|\x02|\x1f|\x16|\x06|\x07//g;
	$target = $nick if($target !~ /^[!&#+]/);

    reload() if ($lastreload + 600 < $ctime or $msg =~ m/^\.reload( szotar)?$/);

	my $text = "";
	foreach my $key (keys %szotar) {
		if($msg =~ m/(^|\s)$key($|\s|[,:;?!])/) {
			if ($text eq "") {
				$text = "$nick: [helyesen] ${szotar{$key}}";
			}
			else {
				$text .= ", ${szotar{$key}}";
			}
		}
	}
	return if ($text eq "");

	$ltime = $ctime;
	$server->command("msg $target $text");
        return;
}

Irssi::signal_add_last("event privmsg", "event_pub");
