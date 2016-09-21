# ODL Summit 2016 Tutorial VM

## Installation

After installing Vagrant and VirtualBox, run

```
vagrant up
```

in this directory.


## Usage

The username and password are both `vagrant`. You can use the VirtualBox GUI as normal or run

```
vagrant ssh
```

to connect to the VM from this directory.


## Details

These scripts:

1. Boot an

    ```
    Ubuntu Desktop 14.04.5 LTS Trusty Tahr (64-bit)
    ```

    virtual machine on VirtualBox via Vagrant.

2. Install and configure 
   - Git, Java 8, and Maven 3.3.
   - FAST, ODL

## Start FAST system

1. Start ODL
   
   ```
   ./distribution-karaf-0.4.3-Beryllium-SR3/bin/karaf
   ```

2. Start FAST system based on ODL
   
   How to install a kar file, please see here
   
   https://wiki.opendaylight.org/view/FAST_Maple_Tutorials:_High-Level_SDN_Programming_using_Algorithmic_Policies#Running_the_hello_world_project
   
3. Play around with your first FAST APP

    https://wiki.opendaylight.org/view/FAST_Maple_Tutorials:_High-Level_SDN_Programming_using_Algorithmic_Policies

## Start IDE

1. Execute start.sh in cloud9
   ```
   ./home/vagrant/tutorial/cloud9/start.sh
   ```

2. Open your browser, and type below URI
   ```
   localhost:9000
   ```
   
   
## Note: Re-generate VM from a clean stage
In your host machine, type:
 ```
 cd ${home_directory_of_this_repo}
 vagrant destroy
 vagrant up
 ```
 
## Generate a Maple APP

In your Virtualbox VM, type:
```
cd /home/vagrant/utils
./gen_archetype_maple
```

You will find a ```hello``` folder in ```/home/vagrant/utils```.
