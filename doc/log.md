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

TODO - Finish s/e issues, digitise storyboard/screen designs. CD/DFD

# 23/02
Finished Check 1 documentation. Merged all files and images into a single PDF and printed.

PROBLEM - MSWord is incredibly stubborn when it comes to page numbers and orientation. It took around an hour to find out how to cheat MSWord into correct placement and rotation of page numbers on horizontal pages.

TODO - 


# 13/03
Setback - laptop development environment is gone due to hdd format + reinstall
Shoes refuses to install on Arch Linux, therefore only have desktop development environment as compile
no loss of data nor progress due to git + backups

PROBLEM - sdd exam is tomorrow

TODO - study, continue to try installing shoes


# 22/03
No way of installing Shoes on laptop, which means compilation is only possible on desktop. Severely limits the portability of my work in exchange for a better development environment?
Started thinking about data structures. User-defined profiles should be saved into config files and on startup read and stored in class instances. Application settings similarly.

PROBLEM - All but forgotten how to use classes in Ruby. Must revise.
- obvious problem of less portability of development

TODO - Revise classes. Find out the best method to format settings + profile configuration files as to maintain ease of use and readability for manual editing


# 02/04
Decided on class structure for user profiles
- user profiles are defined as Profile class instances
- these are initialised on program startup
- class consists of id (autogen on create), nickname, realname, username (optional)
- Profile class includes methods to create, modify, delete
A stored setting should dictate the default class, identified by id. 

TODO - define what needs to go into a Settings file. Determine layout of Profile file. Develop class structure for Settings.

# 03/04
Shoes installed on laptop! Just in time for camp, I can now solely develop on my laptop meaning I can do much more on camp.

# 07/04 - 08/04
Yr 12 study camp. Making great use of the 8 or so free hours between night activity and breakfast. So far, I have branched off the project whilst developing the file IO i.e. classes, methods, file structures. Correctly coded and implemented profile class and profileFile, making use of a nice function I developed which allows reading from files with support for ignoring blank lines and bash-style whole-line comments.

PROBLEM - Due to poor foresight, no local IRC server has been installed, and having spent the greater part of an hour toiling on this issue, I have decided that, bad luck me, I shall develop blind and/or aspects that don't require interaction with the IRC server, such as file IO.

TODO - settingsFile and settings class.

# 09/04
Austin has allowed me to use his IRC channel on the Rizon IRC server to develop and test r.IRC on. Good for me as I do not wish to repeat the hour-long process of configuring an IRC server on my laptop. Since the local IRC server on my desktop still functions, his new availability of a test server means that I can test communication with an IRC server whilst not connected to the LAN at home, as well as providing for realistic delays due to higher ping.

TODO - Rest of Check 2 documentation, such as structure chart, data dictionary, and test data.

# 19/04
Integrated settingsFile and profilesFile into the commandline program and translated a few more IRC commands into Ruby functions. The former action has allowed for the increase in speed of testing, as I not longer have to input user details in order to connect to a test server.

TODO - Make a GUI version of this build. An update to the GUI side of things is long overdue, as I have been focusing on back-end work like file interactions.

# 30/04
Sketched out a boxed, layered layout of the window, including what frames encompass which other frames. This should help me in determining what areas can be isolated in separate submodules, as well as what parameters to pass between these submodules.

# 05/05
A pre-release of Shoes 4 has been published. I have switched to it, because as far as I can determine there are no disadvantages - the missing features in Shoes 4 mostly didn't work in Shoes 3 anyway.

PROBLEM - I just found out that Shoes still has no support for a native application menu e.g. file, edit, help buttons on the window decorations. This is problematic, as I will have to revise my sketches to incorporate these functions on single button - much like how Firefox does it with its unified function button.

# 15/05
Created two new classes - Tab and Application. The former stores information about a single tab, and is to be used as elements in an array that acts as all the tabs. The latter should only have one instance, and is to be used to store general information about the program instance, for example the currently selected tab and the currently selected option in the detail pane.

# 23/05
Rethought the status bar and the identity concept. Having identity profiles was one of the main points of the initial design concept, but it now seems that by strictly implementing this across the program would result in annoyances for the user. For example, nicknames may be in use for a certain server, and the user may be forced to create a new profile for just this instance - personal experience with the Rizon IRC network when my nickname remained in use (ghosted) when I disconnected and reconnected.

TODO - I will need to think of a method to allow users to save their username, nickname, etc. without the strictness of the current identity profile implementation. For now, I need to scale back the integration of profiles throughout the program, limiting it to the initialisation of a connection.

# 04/06
I have merged the GUI with the updated backend, so now r.IRC receives messages and outputs them in the graphical interface rather than in the terminal. Quite a strange problem emerged from this, however; I had devised two methods to implement cross-thread communication. The first was to clear the entire messagebox per every interval of time and then repopulate it with lines taken from a message array, which would be updated by the backend. This seemed extremely inefficient, and so the second method made use of a queue, a stack-like structure, to update the messagebox with new lines. However, using the second method resulted in an inability to interact with the graphical user interface UNLESS the messagebox was being updated, including scrolling.

# I SHOULD PUT STUFF HERE
# don't need to worry about 13/06 to 27/06 - trials were more important

# 01/07
Rather bad roadblock encountered in the form of feature lack. The current version of Shoes, even the development version, does not have support for scroll bars for internal slots. As per the problems this causes, I have decided to revamp the tab system into a multi-window system - as well as mostly solving the problem of a lack of internal scroll bars, this is much easier to work with and manage.

PROBLEM - Having no scrollbars available for internal slots would be detrimental to the tabbed interface as it featured the input box as being separate from the history pane. This meant that the amount of chat history available would be limited by the screen real estate provided to the window - there would be no ability to scroll up to view previous messages

TODO - Draw up sketches and establish an idea of the general program control flow for the windowed system.

# 07/07
Made substantial progress in comparison to the past few sessions.

PROBLEM - I encountered a very strange error where the GUI would stop responding UNLESS a message was incoming i.e. would not respond to scrolling, text selection. I attributed this to my rather roundabout threading of the GUI and the background network I/O threads. I eventually found out that, due to the nature of Ruby's thread scheduler, priority was being given to other threads (not the GUI) when no messages were being received, and so I separated the drawing of the message box contents from the rest of the GUI and limited the maximum lines kept in history to ensure the smoothness of the GUI.

# 18/07
Had major success in packaging a test application into a Java executable. This means that, if such success is repeated for r.IRC, the only pre-requisite to running it is a Java runtime environment (jre7-openjdk).

PROBLEM - The Shoes 4 app packager does not actually run through the application to be packaged; it simply converts it into Java executable code and packages it alongside all other files in the current directory into a Java executable. This caused a minor problem as I was referencing files outside those to be packaged, and so the program would not load these files. This was easily remedied by creating a symbolic link within the current directory to these files and updating 'require' and 'load' statements to point to the new locations.

# 24/07
I have found a roundabout way to combat the error with the massive Java trace that was reported in Check 3. It turned out to be describing an illegal call to schedule a redraw of the GUI without being in sync with the GUI thread (since that is how Java handles its GUI). By including a bit of Java code inside my program, I can specify that a certain block of code is to be asynchronously executed, thus bypassing the scheduling errors. This is probably of limited use since I have already heavily implemented another method, but it is worth mentioning.

TODO - I have completed approximately half of the complete rewrite of r.IRC to match the multi-window design; essential remaining components include several background processes such as auto-response to pings and the user input box.

PROBLEM - With a status bar, I would have to have some way of sending and receiving SPECIFIC commands without the interference of the regular send and receive threads, since the only way to determine the details in the status bar is to query the server. This is also something to consider for the automatic ping-pong module.

# 29/07
With thanks to Michael Morin on About.com, I have devised a regular expression which can be used to analyse incoming raw IRC messages, including separating prefix, command, and parameters. Using this, I can now process messages to be displayed in a more aesthetically pleasing manner, stripping out unnecessary information such as user and host for the PRIVMSG command. More importantly, I can use this to isolate PING commands sent from the server, and thus create an automatic ping response module.

TODO - Make the pingpong module
