# wal colors | xterm colors
#  black		1f2022 	234
#  dark grey    585858  240
#  red 			f2241f	196
#  green 		67b11d  70
#  yellow 		b1951d  136
#  blue 		4f97d7  68
#  purple  		a31db1  127
#  turqoise 	2d9574  30
#  light grey 	a3a3a3  248
#  white 		f8f8f8  231

# to get the html to xterm 256 colors:
# ipython
# from x256 import x256
# x256.from_hex('1f2022')


class DefaultColor(object):
    """
    This class should have the default colors for every segment.
    Please test every new segment with this theme first.
    """
    # RESET is not a real color code. It is used as in indicator
    # within the code that any foreground / background color should
    # be cleared
    RESET = -1

    USERNAME_FG = 231
    USERNAME_BG = 136
    USERNAME_ROOT_BG = 124

    HOSTNAME_FG = 231
    HOSTNAME_BG = 240

    HOME_SPECIAL_DISPLAY = True
    HOME_BG = 68  # blueish
    HOME_FG = 231  # white
    PATH_BG = 30  # dark grey
    PATH_FG = 231  # light grey
    CWD_FG = 231  # nearly-white grey
    SEPARATOR_FG = 231

    READONLY_BG = 124
    READONLY_FG = 254

    SSH_BG = 127  # medium orange
    SSH_FG = 231

    REPO_CLEAN_BG = 148  # a light green color
    REPO_CLEAN_FG = 0  # black
    REPO_DIRTY_BG = 161  # pink/red
    REPO_DIRTY_FG = 188  # white

    JOBS_FG = 39
    JOBS_BG = 238

    CMD_PASSED_BG = 237
    CMD_PASSED_FG = 188
    CMD_FAILED_BG = 167
    CMD_FAILED_FG = 188

    SVN_CHANGES_BG = 148
    SVN_CHANGES_FG = 22  # dark green

    GIT_AHEAD_BG = 240
    GIT_AHEAD_FG = 188
    GIT_BEHIND_BG = 240
    GIT_BEHIND_FG = 188
    GIT_STAGED_BG = 22
    GIT_STAGED_FG = 188
    GIT_NOTSTAGED_BG = 130
    GIT_NOTSTAGED_FG = 188
    GIT_UNTRACKED_BG = 52
    GIT_UNTRACKED_FG = 188
    GIT_CONFLICTED_BG = 9
    GIT_CONFLICTED_FG = 188

    GIT_STASH_BG = 221
    GIT_STASH_FG = 0

    VIRTUAL_ENV_BG = 127  # a mid-tone green
    VIRTUAL_ENV_FG = 231

    BATTERY_NORMAL_BG = 22
    BATTERY_NORMAL_FG = 7
    BATTERY_LOW_BG = 196
    BATTERY_LOW_FG = 7

    AWS_PROFILE_FG = 39
    AWS_PROFILE_BG = 238

    TIME_FG = 188
    TIME_BG = 238


class Color(DefaultColor):
    """
    This subclass is required when the user chooses to use 'default' theme.
    Because the segments require a 'Color' class for every theme.
    """
    pass