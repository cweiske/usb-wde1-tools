PLUGINS = /etc/munin/plugins

install: lninstall

lninstall:
	ln -sf $(abspath init.d/usb-wde-log) /etc/init.d
	insserv usb-wde-log

	ln -sf $(abspath munin/usb-wde1_) $(PLUGINS)/usb-wde1_temperature
	ln -sf $(abspath munin/usb-wde1_) $(PLUGINS)/usb-wde1_humidity

uninstall:
	service usb-wde-log stop
	insserv -r usb-wde-log
	rm -f /etc/init.d/usb-wde-log

	rm -f $(PLUGINS)/usb-wde1_temperature
	rm -f $(PLUGINS)/usb-wde1_humidity

.PHONY: install lninstall uninstall
