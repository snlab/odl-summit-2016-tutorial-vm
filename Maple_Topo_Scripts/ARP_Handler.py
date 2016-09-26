#! /usr/bin/env python
import logging
logging.getLogger("scapy.runtime").setLevel(logging.ERROR)
from scapy.all import *
def arp_monitor_callback(pkt):
    if ARP in pkt and pkt[ARP].op in (1,2): #who-has or is-at
      arp_dst = pkt.sprintf("%ARP.psrc%")
      arp_dst_mac = pkt.sprintf("%ARP.hwsrc%")
      arp_receive_dst = pkt.sprintf("%ARP.pdst%")
#      if arp_dst == "10.0.0.1" or arp_dst == "10.0.0.3":
      if arp_receive_dst == "10.0.0.7":
        send(ARP(op="is-at", pdst=arp_dst, psrc="10.0.0.7/32", hwsrc="00:00:00:00:00:07"), count=1, verbose=False)
        os.system('arp -s '+ arp_dst +' '+arp_dst_mac)
      return           
sniff(prn=arp_monitor_callback, filter="arp", store=0)
