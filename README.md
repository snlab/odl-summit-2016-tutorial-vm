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
```
/*
 * Copyright (c) 2016 SNLAB and others.  All rights reserved.
 *
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License v1.0 which accompanies this distribution,
 * and is available at http://www.eclipse.org/legal/epl-v10.html
 */
package org.opendaylight.mapleapp.impl;

import org.opendaylight.maple.core.increment.app.MapleAppBase;
import org.opendaylight.maple.core.increment.packet.Ethernet;
import org.opendaylight.maple.core.increment.packet.IPv4;
import org.opendaylight.maple.core.increment.tracetree.MaplePacket;
import org.opendaylight.maple.core.increment.tracetree.Route;

public class firstapp extends MapleAppBase {

	private static final String      H1    = "10.0.0.1";
	private static final int H1_IP = IPv4.toIPv4Address(H1);

	private static final String      H2    = "10.0.0.2";
	private static final int H2_IP = IPv4.toIPv4Address(H2);

	private static final int HTTP_PORT = 80;

	// TODO: Better explain the path construct:
	// TODO: Use s1, s2, ... in the construction if possible
	private static final String[] H12_HIGH_PATH = { H1, "openflow:1:3", "openflow:2:2", "openflow:4:1" };
	private static final String[] H12_LOW_PATH  = { H1, "openflow:1:4", "openflow:3:2", "openflow:4:1" };
	private static final String[] H21_HIGH_PATH = { H2, "openflow:4:4", "openflow:2:1", "openflow:1:1" };
	private static final String[] H21_LOW_PATH  = { H2, "openflow:4:5", "openflow:3:1", "openflow:1:1" };

	@Override
	public void onPacket(MaplePacket pkt) {

		int ethType = pkt.ethType();

		// For IPv4 traffic only
		if ( ethType == Ethernet.TYPE_IPv4) {
			
			// H1 (client) -> H2 (server)
			if ( pkt.IPv4SrcIs(H1_IP) && pkt.IPv4DstIs(H2_IP) ) {

				String[] path = null;

				if ( ! pkt.TCPDstPortIs(HTTP_PORT) ) {  // All non HTTP IP, e.g., UDP, PING, SSH
					path = H12_LOW_PATH; 
				} else {                                // Only HTTP traffic
					path = H12_HIGH_PATH;
				}

				// ***TODO***: Need to agree on either Route or Path, not both
				pkt.setRoute(path);

			// Reverse: H2 -> H1
			} else if ( pkt.IPv4SrcIs(H2_IP) && pkt.IPv4DstIs(H1_IP) ) {

				String[] path = null;

				if ( ! pkt.TCPSrcPortIs(HTTP_PORT) ) {
					path = H21_LOW_PATH;
				} else {
					path = H21_HIGH_PATH;
				}
				pkt.setRoute(path);

			// Other host pairs
			} else {

				pkt.setRoute(Route.DROP);

			}
		}                       // end of ethType == Ethernet.TYPE_IPv4

		else {                  // Other type of traffic handled by another Maple App
			passToNext(pkt);
		}

	} // end of onPacket
}


```

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

And then you should follow the steps listed in ODL wiki, and see the result!

## Note: Re-generate VM from a clean stage

In your host machine, type:
 ```
 cd ${home_directory_of_this_repo}
 vagrant destroy
 vagrant up
 ```

