"""Custom topology example

Two directly connected switches plus a host for each switch:

   host --- switch --- switch --- host

Adding the 'topos' dict with a key/value pair to generate our newly defined
topology enables one to pass in '--topo=mytopo' from the command line.
"""

from mininet.topo import Topo
from mininet.util import quietRun
class MyTopo( Topo ):
    "Simple topology example."

    def __init__( self ):
        "Create custom topo."

        # Initialize topology
        Topo.__init__( self )

        # Add hosts and switches
        Host1 = self.addHost( 'h1' )
        Host2 = self.addHost( 'h2' )
        Host3 = self.addHost( 'h3' )
        Host4 = self.addHost( 'h4' )
        Host6 = self.addHost( 'h6' )
        Switch1 = self.addSwitch( 's1' )
        Switch2 = self.addSwitch( 's2' )
        Switch3 = self.addSwitch( 's3' )
        Switch4 = self.addSwitch( 's4' )

        # Add links
        self.addLink( Host1, Switch1 )
        self.addLink( Host3, Switch1 )
        self.addLink( Host2, Switch4 )
        self.addLink( Host4, Switch4 )
        self.addLink( Host6, Switch4 )

        self.addLink( Switch1, Switch2 )
        self.addLink( Switch1, Switch3 )
        self.addLink( Switch2, Switch4 )
        self.addLink( Switch3, Switch4 )

        
  #      h1 = nt.get('h1')
  #      h1.cmd( 'ifconfig h1-eth0 192.168.1.10' )
#	Host2.cmd( 'ifconfig h2-eth0 192.168.1.20' )
 #       Host3.cmd( 'ifconfig h3-eth0 10.0.0.2' )
#        Host4.cmd( 'ifconfig h4-eth0 10.0.0.3' )
 #       leftSwitch.cmd( 'ifconfig s1-eth2 192.168.1.1' )
  #      rightSwitch.cmd( 'ifconfig s2-eth2 192.168.1.2' )
topos = { 'mytopo': ( lambda: MyTopo() ) }
