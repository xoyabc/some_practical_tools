traceroute - print the route packets trace to network host
      
      
       This program attempts to trace the route an IP packet would follow to some internet host by launching probe packets  with
       a  small  ttl (time to live) then listening for an ICMP "time exceeded" reply from a gateway.  We start our probes with a
       ttl of one and increase by one until we get an ICMP "port unreachable" (or TCP reset), which means we got to the  "host",
       or  hit  a  max (which defaults to 30 hops). Three probes (by default) are sent at each ttl setting and a line is printed
       showing the ttl, address of the gateway and round trip time of each probe. The address  can  be  followed  by  additional
       information when requested. If the probe answers come from different gateways, the address of each responding system will
       be printed.  If there is no response within a 5.0 seconds (default), an "*" (asterisk) is printed for that probe.
