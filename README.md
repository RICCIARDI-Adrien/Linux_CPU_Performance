# Linux CPU Performance

## Description

Install a shell script and a systemd service to automatically set "performance" governor on all detected processors.  
Also disable default "ondemand" systemd service (it is automatically re-enabled when removing this program).

## Installation

Install the program by executing the following command :
```
sudo make install
```

Remove the program by executing the following command :
```
sudo make uninstall
```
