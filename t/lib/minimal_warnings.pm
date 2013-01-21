package minimal_warnings;

use strict;
use warnings;
use Test::More;

sub generate_only_some_warnings {
    my @warning_messages;
    local $SIG{__WARN__} = sub {
        my ($message) = @_;
        push @warning_messages, $message;
    };

    # No warnings thrown for this slightly dodgy code.
    my $foo;
    my $bar = $foo . q{ damn, that was an undef wasn't it?};

    my $baz = sort qw(foo bar baz);

    # We do get a warning for this, though.
    my $bletch = unpack("H", "\x{2a1}");

    is(scalar @warning_messages, 1, 'Only one warnings');
    like(
        $warning_messages[0],
        qr/Character in 'H' format wrapped in unpack/,
        'Warning for unpack'
    );
}

1;