# ODL Summit 2016 Tutorial VM

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
   
   
## Note: Re-generate VM from a clean stage

In your host machine, type:
 ```
 cd ${home_directory_of_this_repo}
 vagrant destroy
 vagrant up
 ```
 


## Test Maple App from terminal

Generate your Archetype in interactive mode, only thing your should care is the `DappName`
```
    mvn archetype:generate \
        -DarchetypeGroupId=org.opendaylight.maple \
        -DarchetypeArtifactId=maple-archetype \
        -DarchetypeVersion=1.0.0-Beryllium-SR3
```

