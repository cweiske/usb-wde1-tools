*********************
USB-WDE1 Munin plugin
*********************
Generate graphs for temperature and humidity by utilizing Munin.


Idea
====
0. Keep a logfile with the most recent single line
1. Use the munin plugin to generate munin-compatible data from the log file


Setup
=====
0. Checkout the munin plugin code::

   $ cd /usr/local/src
   $ git clone git://git.cweiske.de/usb-wde1-tools.git
   $ cd usb-wde1-tools

1. A process needs to watch the USB interface and log the last
   line with temperature data into a log file.
   You can do that manually with ::

     $ socat /dev/ttyUSB0,b9600 STDOUT |./munin/log-single-line.sh test.log

   The most easy way is to run ::

     $ cd munin && nohup ./usb-wde1-log-last.sh &

   once. It backgrounds the logging process and logs into ``/var/spool/usb-wde1/usb-wde1-last``.
   This process needs to be started whenever the machine is rebooted.

   The ``systemd/`` directory contains a ``usb-wde1-log.service`` file you can copy to
   ``/etc/systemd/system/``. After copying it, run::

     $ systemctl daemon-reload
     $ systemctl start usb-wde1-log
     $ systemctl status usb-wde1-log
     $ systemctl enable usb-wde1-log

2. Link the munin plugin::

   $ cd /etc/munin/plugins
   $ ln -s /usr/local/src/usb-wde1-tools/munin/usb-wde1_ usb-wde1_temperature
   $ ln -s /usr/local/src/usb-wde1-tools/munin/usb-wde1_ usb-wde1_humidity

3. Configure the plugins:

   Edit ``/etc/munin/plugin-conf.d/munin-node`` and add the following lines::

     [usb-wde1_*]
     env.logfile /var/spool/usb-wde1/usb-wde1-last
     env.host_name House
     env.sensors 0 1 7
     env.sensor0 Living room
     env.sensor1 Kitchen
     env.sensor7 Outside

4. Try it::

     $ munin-run usb-wde1_temperature autoconf

   should echo "yes"
   ::

     $ munin-run usb-wde1_temperature config

   should display the plugin configuration with all environment variables set
   ::

     $ munin-run usb-wde1_temperature
     $ munin-run usb-wde1_humidity

   should display the current values from the log file

5. You are done - enjoy.



Debugging & Development
=======================
The dummy data generator is a small php script that generates log lines
as they would come from the usb-wde1 usb port::

  $ ./dummy-data-generator.php |./munin/log-single-line.sh test.log

Local (non-installed) plugin setup::

  $ cd munin
  $ ln -s usb-wde1_ usb-wde1_temperature
  $ ln -s usb-wde1_ usb-wde1_humidity
  $ cd ..


Running the munin plugin for development purposes is also relatively easy
since you can pass the environment configuration variables
from the munin configuration on the command line::

  $ logfile=test.log sensors="0 1 7" ./munin/usb-wde1_temperature

When you have problems running the munin plugin, try to
remove the line ::

  env.host_name House

from file ``usb-wde1_``


Permission errors
-----------------
::

    cu: open (/dev/ttyUSB0): Permission denied
    cu: /dev/ttyUSB0: Line in use

Only way that I found to fix this was change ownership of `/dev/ttyUSB0` to uucp::

     $ chown uucp /dev/ttyUSB0


HTML/Plain text output
======================
You may use ``htmlreport/gen-html.php`` to generate HTML or plain text
files with the temperature and humidity information.

Install PHP and the PHP rrd extension (``pear install pecl/rrd``) to make it
work.

Run ``gen-html.php`` every 5 minutes.


Static USB device name
======================
When you have multiple serial USB devices attached to the computer,
rebooting may lead to switched ttyUSB* numbers.

A solution is to define a udev rule in ``/etc/udev/rules.d/99-usb-wde1.rules``::

  SUBSYSTEM=="tty", ATTRS{serial}=="XQJ2EJEMADDFYBD3", SYMLINK+="usbwde1"

You can find the serial number in ``dmesg`` output::

  usb 1-3: new full-speed USB device number 2 using xhci_hcd
  usb 1-3: New USB device found, idVendor=10c4, idProduct=ea60, bcdDevice= 1.00
  usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
  usb 1-3: Product: ELV USB-WDE1 Wetterdatenempfänger
  usb 1-3: Manufacturer: Silicon Labs
  usb 1-3: SerialNumber: XQJ2EJEMADDFYBD3

After creating the file, activate it::

  $ udevadm control --reload
  $ udevadm trigger

Now a file ``/dev/usbwde1`` exists.

Modify ``munin/usb-wde1-log-last.sh`` to use the new device file instead
of ``ttyUSB0``.
