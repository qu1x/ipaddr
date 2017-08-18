UNIT_SRC := ipaddr.service
EXEC_SRC := ipaddr
HOOK_SRC := $(wildcard ipaddr.d/*)
LIST_SRC := /run/ipaddr/list

UNIT_DST := /usr/lib/systemd/system/
EXEC_DST := /usr/bin/
HOOK_DST := /etc/ipaddr.d/
LIST_DST := /etc/ipaddr

.PHONY: all
all:
	@echo "Run \`sudo make install' or \`sudo make uninstall'"

.PHONY: install
install:
	install -m 644 -Dt $(UNIT_DST) $(UNIT_SRC)
	install -m 755 -Dt $(EXEC_DST) $(EXEC_SRC)
	install -m 755 -Dt $(HOOK_DST) $(HOOK_SRC)
	ln -s $(LIST_SRC) $(LIST_DST)

.PHONY: uninstall
uninstall:
	rm -f $(UNIT_DST)$(notdir $(UNIT_SRC))
	rm -f $(EXEC_DST)$(notdir $(EXEC_SRC))
	rm -f $(patsubst %,$(HOOK_DST)%,$(notdir $(HOOK_SRC)))
	rmdir --ignore-fail-on-non-empty $(HOOK_DST)
	rm -f $(LIST_SRC) $(LIST_DST)
	rmdir --ignore-fail-on-non-empty $(dir $(LIST_SRC))

Makefile:;
