all:
	@printf "This makefile allows to install or uninstall the program. Please execute 'sudo make install' to install it or 'sudo make uninstall' to remove it.\n"

install:
	@# Make sure this is executed as root
	@if [ $(shell id -u) -ne 0 ]; then printf "\033[31mThis rule must be executed as root.\033[0m\n"; false; fi
	
	@# Install files
	cp cpu-performance /usr/sbin
	chmod +x /usr/sbin/cpu-performance
	cp cpu-performance.service /lib/systemd/system
	
	@# Register and start service
	systemctl enable cpu-performance.service
	systemctl start cpu-performance.service
	
	@# Disable "ondemand" service that may exist on Ubuntu systems
	if [ -e /lib/systemd/system/ondemand.service ]; then systemctl disable ondemand.service; fi

uninstall:
	@# Make sure this is executed as root
	@if [ $(shell id -u) -ne 0 ]; then printf "\033[31mThis rule must be executed as root.\033[0m\n"; false; fi
	
	@# Unregister service
	systemctl stop cpu-performance.service
	systemctl disable cpu-performance.service
	
	@# Remove files
	rm -f /lib/systemd/system/cpu-performance.service
	rm -f /usr/sbin/cpu-performance
	
	@# Re-enable "ondemand" service if it exists
	if [ -e /lib/systemd/system/ondemand.service ]; then systemctl enable ondemand.service; fi

