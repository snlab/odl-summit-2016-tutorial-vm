# ODL Summit 2016 Tutorial VM

## Prerequisite

vagrant and virtualbox

Install vagrant:
```
sudo apt-get install vagrant
```

Download virtualbox from: https://www.virtualbox.org/wiki/Downloads

## Installation

Git clone this repo

```
git clone https://github.com/snlab/odl-summit-2016-tutorial-vm.git
```

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


## Start IDE

1. After SSH'ing into VirtualBox (see above), execute `start.sh` to load cloud9:
   ```
   /home/vagrant/tutorial/cloud9/start.sh
   ```

2. Open the following url in your host machine's browser:
   ```
   localhost:9000
   ```
 

## Test Maple App from terminal

Generate your Archetype in interactive mode, only thing your should care is the `DappName` where Maple's onPacket() lies in, and `artifactId`, which is the generated folder name
```
    mvn archetype:generate \
        -DarchetypeGroupId=org.opendaylight.maple \
        -DarchetypeArtifactId=maple-archetype \
        -DarchetypeVersion=1.0.0-Beryllium-SR3
```

You could find `DappName.java` from here:
```
{home_of_your_maple_app_project}/impl/src/main/java/org/opendaylight/mapleapp/impl/{your_define_name}.java
```

And then you could copy paste the Mapple App Code (M1-M3) from ODL wiki page to this {your_define_name}.java file.

This is an M1 example, you could copy it into your {your_define_name}.java
**Note:** if you set DappName as M1 for M1 example, or as M2 for M2 example, you could directly copy and paste the belowing java file into your {your_define_name}.java file.

M1 example: https://github.com/snlab/fastmaple16/blob/master/M1.java

M2 exmaple: https://github.com/snlab/fastmaple16/blob/master/M2.java

## Build your Maple app

```
cd {artifactId}
mvn clean install -DskipTests
```

## Edit Maple config, and start Maple
```
cd ~/tutorial/maplemain-karaf-1.0.0-Beryllium-SR3/etc
```

Add following line into **org.ops4j.pax.url.mvn.cfg**
```
   org.ops4j.pax.url.mvn.defaultRepositories=\ file:${karaf.home}/${karaf.default.repository}@id=system.repository@snapshots,\ file:${karaf.data}/kar@id=kar.repository@multi@snapshots
```

And then run your Maple,
```
cd ~/tutorial/maplemain-karaf-1.0.0-Beryllium-SR3/bin
./karaf
```

## Install MapleAPP into Maple
In karaf,
```
kar:install file:{directory of your kar file}
```
The kar file will be located in {your_maple_app_directory}/features/target/*.kar

## Start Mininet
In your host machine, the home directory of this repo, type
```
vagrant ssh
```

A new terminal will appear, so that you could use Mininet. Type this to generate Topo based on ODL wiki page.
```
sudo mn --controller remote,127.0.0.1 --custom ~/utils/Maple_Topo_Scripts/exampletopo.py --topo mytopo --switch ovs,protocols=OpenFlow13 --mac
```

And then you should follow the steps listed in ODL wiki https://wiki.opendaylight.org/view/SDN_Programming_using_High_Level_Programming_Abstractions#Build_and_deploy_M1
, and see the result!

## Note: Re-generate VM from a clean stage

In your host machine, type:
 ```
 cd ${home_directory_of_this_repo}
 vagrant destroy
 vagrant up
 ```

