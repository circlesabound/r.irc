# 04/12
Decided on main idea - internet messaging client, using IRC
PROBLEM - Never worked with any sort of networking before. Also, I want this program to be multi-platform, so no VB.NET. 
TODO - Need to determine what language to use and learn how to use networking in that language

# 13/12
Decided on language - Ruby. Discovered a RubyGem known as Ruby-IRC that provides functions to interact with network, planning to use that. Set up development environment - Ubuntu 13.10 - on both home computer and laptop. Set up Git version control, created remote repository at GitHub.
PROBLEM - Ruby-IRC gem has lack of documentation. This means that I must use the process of guess-and-check in order to determine which function is appropriate.
TODO - Need to find a way of implementing a GUI using Ruby. Research required.

# 17/12
Finished the entire Ruby course on codecademy.com - should be sufficient knowledge to begin practicing by myself. Disassociated the Ruby-IRC gem from this project due to later mentioned problems. Decided to directly use TCPSocket as an interface instead of any other gem. Created initial interface designs - inspiration from Mozilla Firefox and FileZilla.
PROBLEM - Ruby-IRC was problematic due to extreme lack of documentation as well as the fact that it refused to install on the laptop.
TODO - Still need to determine a means of implementing GUI

# 23/12
Set up local IRC servers on both development machines. Found a possibly? suitable framework known as ShoesRB that uses Ruby-like syntax to create native GUI windows for all three major platforms (Windows, OSX, GNU/Linux). Refined initial screen designs. Wrote two procedures in pseudocode that sent and received messages respectively.

PROBLEM - Unsure if ShoesRB is suitable - seems a little simplistic and possibly is not able to construct such a complex interface as outlined in current screen designs. Need to somehow run both the receive and send procedures simultaneously in order to create the beginnings of a proper program.

TODO - Research threading - this will allow both of the aforementioned procedures to run together when written in Ruby. Threading would also allow for basic use of event-driven programming.

# 03/01
Made two simple Ruby command line based programs that sent input messages and displayed received messages respectively from the local IRC server, based on previous pseudocode. Began reading through Shoes documentation.

PROBLEM - in order to implement the tab-based solution in mind would require manual drawing of shapes to use as background images for the tabs. This is very tedious.

TODO - Research wxRuby, an alternative Ruby GUI library framework. Research threading

# 07/01
Decided against using wxruby due to later stated issues. Therefore, sticking with Shoes. Finished reading all Shoes documentation. Changed from a multiple-window solution to a single-window solution (compare GIMP to Photoshop), changed screen designs in the process.

PROBLEM - wxruby has issues with installation + not updated

TODO - Research threading. Further modify screen designs in order to comply with limitations of Shoes

# 16/01
Gained basic knowledge of how threading works. Merged the previous two read/write applications together into a single program using multi-threading to run both procedures simultaneously = cmdio.rb. Made a Hello World GUI program using Shoes.

PROBLEM - 

TODO - 

# 23/01
Started making a list of all IRC commands that could/should have a GUI control/window/something. Came up with the idea of identities/profiles, wherein a set of user details (realname, nickname) is saved and used for whichever chat servers the user wishes. Multiple profiles allow users to 'be' different identities on different channels at different times, preserving anonymity to a limited extent.

PROBLEM - 

TODO - Create storyboards. Finish command list.

# 03/02
Made basic storyboard of first-time-user's path: create identity > connect to server > join channel. Continued IRC command list.

PROBLEM - Ruby's 'include' function acts strangely (in comparison to other languages).

TODO - Figure out how to include methods from other files in Ruby.

# 11/02
Found a Ruby-equiv of 'include' = load(). Implemented a half-finished command module list into cmdio.rb. Works ok.

PROBLEM - quit command does not perform as expected. It needs to break the send loop, kill the receive thread, join and end the send thread, close the connection, then end the program.

TODO - find out why cmdio is exiting with error codes instead of the above mentioned.

# 16/02
Getting started on official documentation for Check 1: Understanding and Defining the Problem. Designed a new document theme and title page. Started Social/Ethical issues.

PROBLEM - 

TODO - Finished s/e issues, digitise storyboard/screen designs. CD/DFD

# 23/02
Finished Check 1 documentation. Merged all files and images into a single PDF and printed.

PROBLEM - MSWord is incredibly stubborn when it comes to page numbers and orientation. It took around an hour to find out how to cheat MSWord into correct placement and rotation of page numbers on horizontal pages.

TODO - 


