# r.irc constants


# MISC
VERSION = "v1.0"
IRC_REGEX = /
	(?<param>[^\ :]+){0}
	(?<trailing>[^\r\n]+){0}

	(?<nick>[^!:]+){0}
	(?<user>[^@:]+){0}
	(?<host>[^\ :]+){0}

	(?<prefix_host>\g<host>){0}
	(?<prefix_user>\g<nick>(!\g<user>(@\g<host>))){0}

	(?<prefix>:(\g<prefix_user>|\g<prefix_host>)){0}
	(?<command>[0-9A-Z]+){0}
	(?<params>(\g<param>\ ?)?){0}

	^(\g<prefix>\ )?(\g<command>\ )?(\g<params>)?:?(\g<trailing>)?(\r\n)?$
/x
# thanks to Michael Morin on About.com Ruby

# MAIN MENU
MENU_WIDTH = 300
MENU_HEIGHT = 500

# CHAT WINDOW
WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 700

# SETTINGS WINDOW
SETTINGS_WIDTH = 400
SETTINGS_HEIGHT = 400

# HELP WINDOW
HELP_WIDTH = 500
HELP_HEIGHT = 700

# FONT
FONT_TITLE = "DINPro 47px"
FONT_SIZE = 9

# HELP CONTENTS
HELP_PAGE_1 = "\nWelcome to r.IRC, the revolutionary IRC client written in Ruby.\n\nr.IRC comes pre-configured with optimal settings to allow for inexperienced users to avoid any steep learning curves. It is thus unnecessary for new users to toy with any options in the settings menu.\n\nWhen starting a new chat, a new window will appear with input boxes to configure the connection. Many IRC servers exist on the Internet, and the user is encouraged to undertake further research in order to locate popular servers and channels."
HELP_PAGE_2 = "\nThe server field designates the URL of the IRC server that is to be connected to. As previously stated, these are in abundance on the Internet and the user is encouraged to conduct personal research on these.\n\nThe port field designates the network port that will be used to connect to the server; the default is 6667 and this field is pre-emptively filled.\n\nIRC channels are the individuals chatrooms on an IRC server, wherein useres can communicate with others in the same channel. Similar to the servers themselves, many popular channels exist on large IRC servers and users are encouraged to further research to find channels to suit their interests.\n\nThe password is an optional field used when connecting to password restricted channels. Most channels are open and do not require a password, and this field can be left blank otherwise."
HELP_PAGE_3 = "\nUser modes are flags that describe how the IRC server and all other users will view and interact with the user. There are a multitude of user modes, such as the invisibility flag, which when set does not alert others in the IRC channel to the invisible user's presence.\n\nThe nickname is the name displayed next to the user's sent messages. There is a maximum length of 9 characters and cannot contain several non-alphanumeric characters.\n\nThe username is the identifying name of the user, and is used by the IRC server to properly communicate with the client.\n\nThe real name is displayed to other users when they run the \'whois\' command. It does not necessarily have to be your real name."
HELP_PAGE_4 = "\nr.IRC's profile system allows for users to save defined sets of a username, nickname, and a real name. The profile system saves significant amounts of time when using IRC with frequently reused online identifiers.\n\nA set of identifiers can be saved as a profile by pressing the \'Save profile\' button, and entering a suitable profile name. The profile can then be recalled by selecting it from the drop-down menu, which will then automatically fill the relevant form fields with the saved data.\n\nAfter filling all required fields, press the \'Join\' button and wait several moments to connect to the IRC server and join the channel."
HELP_PAGE_5 = "\nThe main interface of r.IRC consists of a history pane, a message input box, and a status bar.\n\nThe history pane occupies the bulk of the window, and details the past messages and the output of any IRC commands.\n\nThe message input box is under the history pane, and allows the users to enter messages and IRC commands, prefixed with a forward slash (\/) to be sent to the channel using the \'Send\' button.\n\nThe status bar is at the bottom, and contains various statistics about the connection, including current nickname, current channel modes, current user modes, and the status of the connection to the IRC server."