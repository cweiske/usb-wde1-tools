PLUGINS = /etc/munin/plugins

install: lninstall

lninstall:
	ln -sf $(abspath systemd/usb-wde1-log.service) /etc/systemd/system/
	systemctl daemon-reload
	systemctl start usb-wde1-log
	systemctl enable usb-wde1-log

	ln -sf $(abspath munin/usb-wde1_) $(PLUGINS)/usb-wde1_temperature
	ln -sf $(abspath munin/usb-wde1_) $(PLUGINS)/usb-wde1_humidity

uninstall:
	systemctl stop usb-wde1-log
	systemctl disable usb-wde1-log
	rm /etc/systemd/system/usb-wde1-log.service
	systemctl daemon-reload

	rm -f $(PLUGINS)/usb-wde1_temperature
	rm -f $(PLUGINS)/usb-wde1_humidity

.PHONY: install lninstall uninstall
