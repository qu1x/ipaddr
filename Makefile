UNIT_SRC := ipaddr.service
EXEC_SRC := ipaddr
HOOK_SRC := $(wildcard ipaddr.d/*)

UNIT_DST := /usr/lib/systemd/system/
EXEC_DST := /usr/bin/
HOOK_DST := /etc/ipaddr.d/

SYSTEMCTL := $(shell command -v systemctl 2> /dev/null)

.PHONY: all
all:
	@echo "Run \`sudo make install' or \`sudo make uninstall'"

.PHONY: install
install:
	install -m 644 -Dt $(UNIT_DST) $(UNIT_SRC)
	install -m 755 -Dt $(EXEC_DST) $(EXEC_SRC)
	install -m 755 -Dt $(HOOK_DST) $(HOOK_SRC)
ifdef SYSTEMCTL
	systemctl daemon-reload
	systemctl enable ipaddr
	systemctl restart ipaddr
endif

.PHONY: uninstall
uninstall:
ifdef SYSTEMCTL
	systemctl disable ipaddr
	systemctl stop ipaddr
endif
	rm -f $(UNIT_DST)$(notdir $(UNIT_SRC))
	rm -f $(EXEC_DST)$(notdir $(EXEC_SRC))
	rm -f $(patsubst %,$(HOOK_DST)%,$(notdir $(HOOK_SRC)))
	rmdir --ignore-fail-on-non-empty $(HOOK_DST)
ifdef SYSTEMCTL
	systemctl daemon-reload
endif

Makefile:;
