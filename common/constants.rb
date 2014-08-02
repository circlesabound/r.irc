# r.irc constants


# MISC
VERSION = "v0.4b"
IRC_REGEX = /
	(?<param>[^\ :]+){0}
	(?<trailing>[^\r\n]+){0}

	(?<nick>[^!:]+){0}
	(?<user>[^@:]+){0}
	(?<host>[^\ :]+){0}

	(?<prefix_host>\g<host>){0}
	(?<prefix_user>\g<nick>(!\g<user>(@\g<host>)?)?){0}
	
	(?<prefix>:(\g<prefix_user>|\g<prefix_host>)){0}
	(?<command>[0-9A-Z]+){0}
	(?<params>(\g<param>\ ?)?){0}

	^(\g<prefix>\ )?(\g<command>\ )?(\g<params>)?:(\g<trailing>)?(\r\n)?$
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
HELP_WIDTH = 400
HELP_HEIGHT = 400

# FONT
FONT_TITLE = "DINPro 47px"

# SETTINGS
# should honestly migrate these to settingsFile
FONT_SIZE = 9
MAX_HISTORY = 500