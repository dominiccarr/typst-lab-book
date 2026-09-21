#import "lab.typ": *

#show-solutions.update(false)
#dom-hints.update(false)
#delivery-notes.update(false)
#lab-counter.update(100)

#show: labs(
  title: "ITN Labs",
  author: "Dominic Carr",
)[

#import "@local/labs:0.1.8" as lab: *

#heading(supplement: "PT")[Basic Switch Configuration]

#goal[
  In this lab we will perform basic configuration of a CISCO switch using the command line interface of the device. We will gain familiarity with Packet Tracer and the Cisco IOS. 
]

#important-note[
  It might be useful for you to refer to A for common IOS commands and details about the different execution privileges.
]

#delivery-note[15/09/26]

== Steps

=== Build the Topology

+ We will the topology shown in
+ Select the *Switch 2950 - 24* and add it
+ Add two generic *PCs*
+ Don't wire up the machines yet

=== Program the Switch
+ We need to program the switch _via_ the PC.
	+ Need to connect them
	+ Choose the console cable from connections
	+ Connect from the *RS232* on the PC to the *Console* port on the switch
+ Click on the PC, go to the Desktop tab and open the Terminal program
+ Leave the settings as they are, and click OK. 
+ We are now in the programming interface of the switch
+ You should see the `Switch>` prompt. This indicates that you are in User EXEC mode on the switch. 
+ Enter ``` enable ```
+ Enter ``` configure terminal```
+ We are now in configuration mode, we can change the name of the switch by executing ``` hostname cisco```
+ To configure one of the Ethernet ports type ``` interface fastethernet 0/1 ```
+ To open the port we type ``` no shutdown```
+ Type ``` exit ``` to return
+ Repeat these steps with FastEthernet 0/2
+ Once that is done you can close the console.

=== Wire it up
+ Connect the first PC to the FastEthernet 0/1 using a copper straight-through
+ Connect the second PC to the FastEthernet 0/2 using a copper straight-through
+ Configure the IP addresses of the two machines as ``` 10.0.0.1``` and ``` 10.0.0.2```
+ You should see the connections turn green

=== Communicate

+ You can now ping from PC1 to PC2

]