# Personal dotfiles

### Additional steps
For current laptop (system76 galp5) a few things need to happen.

#### Laptop backlight control
The `change-brightness` script is used for backlight control. It requires the udev rule in `root/etc/udev/rules.d/99-backlight.rules`.

The udev rule modifies the backlight so it is owned by the **video** group. Make sure user is part of the **video** group.
```
sudo usermod -aG video $USER
```
(currently, the udev rule doesn't have any good restrictions setup because the gpu seems to load without hwdb info)

#### Changing graphics mode
The `nvidia-utils` package loads the **nvidia-uvm** module.
This module [seems to cause](https://github.com/pop-os/system76-power/issues/252) issues with switching between integrated vs dedicated graphics.
Commenting out the module in `/usr/lib/modules-load.d/nvidia-utils.conf` makes it not load.

#### More nvidia nonsense
> **nvidia** package may not boot on Linux 5.18 (or later) on systems with Intel CPUs [likely only of 11th Gen and onward](https://newsroom.intel.com/editorials/intel-cet-answers-call-protect-common-malware-threats/#gs.mg8nm2) due to [74886](https://bugs.archlinux.org/task/74886)/[74891](https://bugs.archlinux.org/task/74891). Until this is fixed, a workaround is disabling the [Indirect Branch Tracking](https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/007/indirect-branch-tracking/) CPU security feature by setting the `ibt=off` kernel parameter from the bootloader. This security feature is responsible for [mitigating a class of exploit techniques](https://lwn.net/Articles/889475/), but [is deemed safe as a temporary stopgap solution](https://www.reddit.com/r/archlinux/comments/v0x3c4/psa_if_you_run_kernel_518_with_nvidia_pass_ibtoff/).
>
> -- *[archlinux wiki](https://wiki.archlinux.org/title/NVIDIA)*
