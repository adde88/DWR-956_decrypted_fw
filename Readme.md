# D-link DWR-956 Firmware

This repository contains both the encrypted, decrypted and the extracted content of all firmware versions for D-link DWR-956. 4G/LTE WiFi Router (2.4Ghz + 5Ghz)  

------------------------------------------------
Folder structure:

./decrypted_and_extracted :	This contains each firmware versions decrypted and extracted content. Both the kernel and squashfs-root directories.  
./decrypted_fw_img : Original un-modified firmware files. Decrypted. (Also contains keys and script to decrypt fw.)  
./original_fw : Original firmware files. Encrypted.  
./original_lte_fw	: Original 4G/LTE modem firmware files. Encrypted.  

------------------------------------------------
The root password for DWR-956 is: H00rnstuu11  

The /etc/passwd within the firmware is a 'fake' file.  
The real passwords are read from /dev/mtd13 by some custom software.  

------------------------------------------------
/dev/mtd13 (sysconfig) uses 2142KB space. It contains gzip compressed data, which real size after extraction only takes 115KB disk-space.  
This means the rest of the data is just random padding.  

The data from mtd13 is read by some custom software (jnrp-utils), and contains lots of settings used by the router. Including the root password. Which is read upon boot.  
To change the root password we need to extract the data -> de-compress it -> alter it -> re-compress it -> add some padding to reach 2142KB, and finally write the file to /dev/mtd13 by using mtd.  

------------------------------------------------
One rather interesting thing about this router is that it's running some kind of remote managment software (TR-069), which the user is totally unaware of.  
You can actually turn this off by going to this url: http://192.168.1.1/system/tr69.asp  
It looks like they forgot to remove this part of the interface completely when they shipped it out, because you cannot find any links to that site within the interface.  
I only found out about it after rooting the device.  

The interesting thing is that the router keeps contacting http://dwr923acs.telenor.net/ using some HTTP/SOAP protocol.  
Device provisioning Code: HANT.0000  
Username: hant  
Password: totusen  

Telenor would then be able to remotely manage my router.  
In a worst case scenario they could actually look at whatever i'am doing on the internet, even after changing to another subscriber.   
All this without my knowledge, and without my consent.
