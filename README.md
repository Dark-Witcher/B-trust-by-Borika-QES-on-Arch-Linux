# Installing Borical B-trust QES on Arch Linux

 ## This is a step by step guied on how to install the B-trust Qualified Electronic Signature on Arch Linux

### Install "yay" or another AUR frontend.

#### Install prerequisites:
~~~bash
 sudo pacman -S --needed git base-devel
~~~

#### Clone the Yay repository and build and install yay:
~~~bash
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
~~~

---------
### You can use the install.sh to do this part for you.

I am leaving the instructions if you decide to do it by hand.

#### Install the Smart Security Card Reader Tools:
~~~bash
sudo pacman -Sy opensc ccid pcsc-tools pcsclite
~~~

#### Install SafetyNet Authentication and B-trust Biss:
~~~bash
yay -Sy sac-core sac-gui btrustbiss
~~~

#### Browser and App support

##### Add Gemelto PKCS11 to the security library
~~~bash
modutil -add "libIDPrimePKCS11.so" -libfile libIDPrimePKCS11.so -dbdir sql:$HOME/.pki/nssdb -mechanisms FRIENDLY
~~~

- If you get "modutil: function failed SEC_ERROR_BAD_DATABASE: security library: bad database" run the following commands in the terminal:
~~~bash
mkdir $HOME/.pki && mkdir $HOME/.pki/nssdb
~~~

After doing that run again:
~~~bash
modutil -add "libIDPrimePKCS11.so" -libfile libIDPrimePKCS11.so -dbdir sql:$HOME/.pki/nssdb -mechanisms FRIENDLY
~~~

-------------------

##### For Chromium Based Browsers
- Download the automated installer for the security sertificates from [here](https://www.b-trust.bg/attachments/BtrustPrivateFile/29/docs/BTrust-CAs.p12).
- Go to your browsers settings -> certificates and from **Your certificates** press **Import**.
- Select and load the downloaded file - **Btrust-Cas.p12**.
- The file will reqest a password - leave the field empty and click **OK**.
- After go to **Authorities**
- Find all seven sertificates by **B-trust**
    - B-trust Root CA
    - B-trust Operational CA AES
    - B-trust Operational CA QES
    - B-trust Operational Advanced CA
    - B-trust Operational Qualified CA
    - B-trust Root Advanced CA
    - B-trust Root Qualified CA
- For each certificate press the **three dots** and click **Edit**
- For each certificate mark each **Trust this certificate...** option.
- Restart your PC, 

##### For Firefox  Based Browsers
- Download the security certificates:
    - [http://ca.b-trust.org/repository/B-TrustRootQCA_DER.crt](http://ca.b-trust.org/repository/B-TrustRootQCA_DER.crt)
    - [http://ca.b-trust.org/repository/B-TrustRootACA_DER.crt](http://ca.b-trust.org/repository/B-TrustRootACA_DER.crt)
    - [http://ca.b-trust.org/repository/ca5/RootCA5_DER.crt](http://ca.b-trust.org/repository/ca5/RootCA5_DER.crt)
    - [http://ca.b-trust.org/repository/B-TrustOperationalQCA_DER.crt](http://ca.b-trust.org/repository/B-TrustOperationalQCA_DER.crt)
    - [http://ca.b-trust.org/repository/B-TrustOperationalACA_DER.crt](http://ca.b-trust.org/repository/B-TrustOperationalACA_DER.crt)
    - [http://ca.b-trust.org/repository/ca5/OperCA5QES_DER.cer](http://ca.b-trust.org/repository/ca5/OperCA5QES_DER.cer)
    - [http://ca.b-trust.org/repository/ca5/OperCA5AES_DER.cer](http://ca.b-trust.org/repository/ca5/OperCA5AES_DER.cer)
- Deactivate **"OS Client Cert Modul"** by going to **[about:config](about:config)** and setting **security.osclientcerts.autoload** to **false**.
- Select and load the downloaded file - **Btrust-Cas.p12**.
- Go to **Preferences/Settings -> Privacy & Security  -> Security Devices…**
- Select **Load** and then **Browse**
- Select the **libDPrimePKCS11.so** from **/usr/lib/pkcs11/**
- In the fields **Deatils** and **Value** you should now see data for **Label,  Manufacturer, Model of the Card and S/N Number**. Close it.
- Go to **Preferences/Settings -> Privacy & Security  -> View Certificates…**
- It will request your QES PIN - enter it.
- From **Certificate Manger** go to **Authorities**
- Import each of the downloaded certificates and for each certificate mark each **Trust this certificate...** option when importing them.
- Restart your PC.
