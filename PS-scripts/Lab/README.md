# Script for Hyper-V lab environment #

These set of scripts are meant to help and aid in creating a dynamic lab environment with some static elements to get started.
This code is prepared to be set up in a nested Hyper-V environment with isolated networks and is possible to scale out to a multi-domain environment if desired.

The static elements consits of two .vhd files that need to be downloaded and act as parent disks to the VMs.
Since this module is a nested environment, you first need to configure the bare-metal machine to run Hyper-V, then create the host machine where the actual lab environment will be at.

My recommandation is that the host machine will need 16 GB or 32 GB of RAM, one to two .vhd(x)'s and two network adapters. Additionally it needs to support hardware acceleration in order to run a nested environment. All of this is is available to configure with my scripts.

The scripts are numbered in a chronologial order for best practice. However, I strongly recommend to first look at the code to familiarize yourself with the operations you're about to execute, this way you can tweak and modify the parts as you wish to and create your desired environment.

For security reasons the Active Directory domain is set to a domain and forest functioning level at Windows Server 2012, although the servers themselves run Windows Server 2016 and/or Windows Server 2019.

## Additional tools aside from the script is as follows ##
* A .csv file with dummy data to be imported
* Links to two .vhd files containing clean installations of Windows Server 2016 and Windows Server 2019 respectively

## In broad terms the script does the following ##
1. Install Hyper-V, its dependencies and management tools
    - 1.1 Create two network adapters, WAN and LAN
    - 1.2 Create the VM with one of the provided .vhd files and both net adapters
    - 1.3 Allow it to run nested virtualization

2. Change the hostname for the host machine

3. Change the IP address for the host machine

4. Installing AD DS, DNS, creating a domain
    - 4.1. Promoting the host to a domain controller

5. Installing DHCP on the host machine
    - 5.1. Creating a new DHCP scope that'll be used be the VMs

6. Installing the Hyper-V role with its management tools

7. Installing the DHCP role
    - 7.1. Creating a new DHCP scope that'll be used by the VMs

8. Creating the VMs for the environment

9. Starting the VMs

10. Change the hostnames for the VMs

11. Changing IP address of the VMs if desired

12. Installing AD DS, DNS and creating a domain on a VM
    - 12.1 Promoting the VM to a domain controller

13. Adding VMs to the domain

14. Creating Organizational Units in the domain

15. Importing the .csv file with dummy data to add users to the domain

16. Create domain-wide shares

17. Create homefolders for each users

This is the intial version of my vision for this environment, the only unfortunate thing is that the installation process for each machine is manual due to security reasons, custom password, product keys, consent to the EULA and language preference. These four areas are the only areas that appear in the installation process, everything else is automated.

You will find all information and all resources in the repository to get you started!
