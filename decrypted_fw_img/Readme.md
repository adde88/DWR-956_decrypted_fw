# Decrypted Firmwares

Original firmwares fetched from: http://stup.telenor.net/  

Decrypted with: decrypt_original_fw.sh  

D-link / Telenor have encrypted the firmwares using the DES implementation provided by OpenSSL.  
It also looks like it exists several versions of the DWR-956 (branches).  
Each branch, has its own firmware, and its own encryption key.  


OpenSSL DES Keys:  
97331723P01001  
97331723P01002  
97331723P01003  
97331723P02001  
97331723P02002  
97331723P02003  

The first key, matches the P01001 branch. And so it goes on.  
The last key: 97331723P02003 is used to decrypt the firmwares i provided here.  


sha256sum:  
b35b8316274423c4fe734b7ac4e69bca53ecaaca14ef966f164d2583b011e21d  -  dwr956_v1.0.0.7_r02_nb_p02003.img
ba7c7e91e9c2ed391d35968b06a2c49f9782f4a80fa2898adb7ba2ee51b63f0b  -  dwr956_v1.0.0.8.img
4cc57584ea2e65be4f6bd1aa37b918088cc0b3a62ae7a178b057d326c25ec5c2  -  dwr956_v1.0.0.9_r06_nb_p02003.img
9c9303cb7e1d5f2f3aad7f31548b751f7bc2bbc9a34cec17308db56604c25c16  -  DWR956_v1.0.0.11_r03_NB_P02003.img
