# Single source of truth for the system color theme.
#
# Theme: Tokyo Night (Moon), leaning into soft pink/purple accents.
# Values are bare 6-digit hex (no leading #) so each generator can prefix as its
# format needs. After editing, run ~/.config/theme/build.sh and reload apps.

# --- backgrounds (dark -> light) ---
BG=222436        # main background
BG_DARK=1e2030   # darker panels
BG_DEEP=191a2a   # deepest / shadow
SURFACE=2f334d   # raised surface (bar, popups)
OVERLAY=3b4261   # selections / borders
MUTED=545c7e     # dim text, empty workspaces, comments

# --- foregrounds ---
SUBTEXT=828bb8   # secondary text
FG=c8d3f5        # primary text

# --- accents ---
PURPLE=c0a7f5    # PRIMARY accent (soft purple) — focus, borders, prompt
PINK=f5a3c7      # SECONDARY accent (soft pink)
BLUE=82aaff
CYAN=86e1fc
GREEN=c3e88d
YELLOW=ffc777
ORANGE=ff966c
RED=ff757f
