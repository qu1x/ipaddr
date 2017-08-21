# ipaddr

Monitor network interfaces for IP address changes

Requires `ip` only, optionally `systemd`.

## Usage

```text
$ ipaddr
enp1s0 fe80::2/64
enp1s0 2001:db8::1:2/64
enp1s0 192.0.2.102/24
wlp2s0 2001:db8::2:2/64
wlp2s0 192.0.2.202/24
$ ipaddr --help
IP Address Monitor

ipaddr [OPTION]
  If a monitor is running on the same $IPADDR_WORK directory and the
  $IPADDR_HOOK/20-list hook is executable, all currently assigned IP addresses
  are listed in the format of the event variable $list.

ipaddr monitor
  Monitor network interfaces for IP address changes. Hooks in $IPADDR_HOOK are
  executable or ignored. They are entered in lexical order and have access to
  the environment and event variables listed below. Hooks are advised to wrapped
  file operations with `flock'. Long hooks delay subsequent events but no event
  is ever missed.

OPTIONs:
  -h, --help     Print help.
  -v, --version  Print version.

Environment variables:
  $IPADDR_WORK  /run/ipaddr
  $IPADDR_HOOK  /etc/ipaddr.d

Event variables:
  $list           <list of all currently assigned addresses
                    as "$interface $address/$prefix\n"
                    in the order they have been assigned
                    inclusive the current $action>
  $action         assign|update (lifetime via RA)|resign
  $index          <network interface index>
  $interface      <network interface name>
  $family         inet|inet6
  $address        <IP address>
  $prefix         <number of prefix bits>
  $brd            <broadcast address (inet only)>
  $scope          <as of `ip-address'>
  $flag_list      <as of `ip-address' but separated with "\n">
  $valid_lft      <as of `ip-address' but without "sec" postfix>
  $preferred_lft  <as of `ip-address' but without "sec" postfix>

Executable hooks:
  /etc/ipaddr.d/10-echo
  /etc/ipaddr.d/20-list
```

## Installation

```text
$ sudo make install
install -m 644 -Dt /usr/lib/systemd/system/ ipaddr.service
install -m 755 -Dt /usr/bin/ ipaddr
install -m 755 -Dt /etc/ipaddr.d/ ipaddr.d/10-echo ipaddr.d/20-list
systemctl daemon-reload
systemctl enable ipaddr
systemctl restart ipaddr
```

## Uninstallation

```text
$ sudo make uninstall
systemctl disable ipaddr
Removed /etc/systemd/system/network.target.wants/ipaddr.service.
systemctl stop ipaddr
rm -f /usr/lib/systemd/system/ipaddr.service
rm -f /usr/bin/ipaddr
rm -f /etc/ipaddr.d/10-echo /etc/ipaddr.d/20-list
rmdir --ignore-fail-on-non-empty /etc/ipaddr.d/
systemctl daemon-reload
```

## License

Copyright (c) 2017 Rouven Spreckels <n3vu0r@qu1x.org>

Usage of the works is permitted provided that
this instrument is retained with the works, so that
any entity that uses the works is notified of this instrument.

DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the works by you shall be licensed as above, without any
additional terms or conditions.
