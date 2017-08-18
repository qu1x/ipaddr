# ipaddr

Monitor network interfaces for IP address changes

## Installation

```sh
sudo make install
sudo systemctl daemon-reload
sudo systemctl enable ipaddr
sudo systemctl start ipaddr
```

## Usage

```text
$ ipaddr --help
IP Address Monitor

ipaddr [OPTION]
  Monitor network interfaces for IP address changes until terminated or
  `ip monitor address' ends.

  Hooks in /etc/ipaddr.d are executable or ignored. They are entered in
  lexical order and have access to the environment and event variables
  listed below. Hooks are advised to wrapped file operations with `flock'.
  Long hooks delay subsequent events but no event is ever missed.

OPTIONs:
  -h, --help     Print help.
  -v, --version  Print version.

Environment variables:
  $IPADDR_FEED  ip monitor address
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
  $flag_list      <as of `ip-address'>
  $valid_lft      <valid lifetime in seconds>
  $preferred_lft  <preferred lifetime in seconds>

Executable hooks:
  /etc/ipaddr.d/10-echo
  /etc/ipaddr.d/20-list
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
