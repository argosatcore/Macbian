# Documentation on how to install Debian GNU/Linux on a defective 2011 MacBook Pro.

The primary object of this documentation is to have an up to date manual in order to have an usable machine running a robust OS like Debian. Due to the infamous dedicated graphic cards fiasco found on 2011 Macbook Pros, running Mac OS X was no longer a viable option due to its inablity to avoid the detection of the defective graphic card. The free and open source nature of Linux OS's, like Debian, allows one to modifiy the kernel's parameters to make the machine use only the integraded graphic card, thus making the machine usable again.

This guide is certainly no written from scratch, but it is a debianized version of a guide that used the LTS version of Ubuntu as the replacement OS. This guide was written by Orville Bennett. You can find the original guide here [https://orville.thebennettproject.com/articles/installing-ubuntu-14-04-lts-on-a-2011-macbook-pro/].

![rect830-3-3-36](https://user-images.githubusercontent.com/64110504/94893124-a73c5100-0443-11eb-9bd2-039d037423e5.png)

---

# Why Debian and not some other OS?

This is a licit question, specially given the vast number of Linux ditributions. The reason why I chose Debian as oposed to a distribution with more regular point releases or a rolling release is because the parametric modifications made to the Linux Kernel and to the Grub Bootloader need to be re written each time any of this components is updated. Due to the impredictable nature of regular releases, having a consistent and predictable system that keeps changes to the bare minimun reduces the chances of having to go through these guide again. Debian meets all the previous conditions: it's one of the most stable, robust and well designed Linux distributions out there. 

---

# Requirements

1-A flashdrive with a live non-free version of the current stable branch of the Debian GNU/Linux Operating System.

2- A 2011 MacBook Pro with a defective dedicated graphics card.

# Steps
1-Turn on the defective MacBook Pro (or restart if it was already on) and immediately press and hold the `option` key. 

2-Select the usb key that contains that Debian GNU/Linux OS. After you have selected it, you will be greeted by th Grub bootloader menu.

3-Once in the booloader menu, press the `e` key in order to edit the boot parameters.

4-Look for the line set gfxpayload=keep. Once you’ve found it, type the following lines underneath to disable the AMD graphics card:
    
    outb 0x728 1
    outb 0x710 2
    outb 0x740 2
    outb 0x750 0
    
5-Next find the kernel line and after “quiet splash” , add the following:
    
    i915.lvds_channel_mode=2 i915.modeset=1 i915.lvds_use_ssc=0

6-Press the `f10` key to save the changes made to the boot parameters.

7-Now you should be able to use the integrated graphics, thus eliminating any graphical glitches that made the computer unusable before. Boot into a `live-session`.

8- Proceed with the installation of the OS.

9-Reboot.

10-Repeat steps 1 to 6.

# TODO: Finish the steps, polish overall writing.
