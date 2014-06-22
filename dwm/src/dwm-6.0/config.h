/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "-*-MonteCarlo-medium-r-*-*-*-*-*-*-*-*-*-*";
static const char normbordercolor[] = "#a5caef";
static const char normbgcolor[]     = "#1b1b1b";
static const char normfgcolor[]     = "#a5caef";
static const char selbordercolor[]  = "#e8e8e8";
static const char selbgcolor[]      = "#1b1b1b";
static const char selfgcolor[]      = "#e8e8e8";
static const char urgbgcolor[]	    = "#1b1b1b";
static const char urgfgcolor[]	    = "#8b171a";
static const char urgbordercolor[]  = "#f8f8f8";
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx	    = 4;	/* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */
static const unsigned int systrayspacing = 1;                // space between systray icons
static const Bool showsystray            = True;             // False means no systray

/* tagging */
static const char *tags[] = { "terms", "web", "code", "files", "doc", "media" };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       1 << 5,           False,   -1 },
	{ "Inkscape",	NULL,	  NULL,	      1 << 4,		False,	 -1 },
	{ "Firefox",  NULL,       NULL,       1 << 1,       False,       -1 },
	{ "URxvt" , NULL,	  NULL,	      1 << 0,	    False,	 -1 },
	{ "Chromium",	NULL,	  NULL,	      1 << 1,	    False,	 -1 },
	{ "Google-chrome", NULL,  NULL,	      1 << 1,	    False,	 -1 },
	{ "Dwb",	NULL,	  NULL,	      1 << 1,	    False,	 -1 },
    { "URxvt",  "vim",    "vim",      1 << 2,       False,  -1},
	{ "Thunar",  NULL,	  NULL,	      1 << 3,	    False,	 -1 },
	{ "Acroread", NULL,	  NULL,	      1 << 3,	    False,	 -1 },
	{ "gpicview",  NULL,	  NULL,	      1 << 3,	    False,	 -1 },
	{ "libreoffice-writer", NULL, NULL,   1 << 4,	    False,	 -1 },
	{ "libreoffice-calc", NULL, NULL,     1 << 4,	    False, 	 -1 },
	{ "Lyx",	NULL,	NULL,	      1 << 4,	    False,	 -1 },
	{ "Gvim", 	NULL,	NULL,	      1 << 4,	    False,	 -1 },
	{ "VLC",	NULL,	NULL,	      1 << 5,	    True,	 -1 },
    { "URxvt", "ranger", "ranger",   1 << 3,       False,  -1 },
    { "URxvt", "ncmpcpp", "ncmpcpp", 1 << 5,       False,  -1 },
	{ "MPlayer",	NULL,	NULL,	      1 << 5,	    True,	 -1 },
};

/* layout(s) */
static const float mfact      = 0.60; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
/* Include XF86 Keys */
#include <X11/XF86keysym.h> 
/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", "-*-montecarlo-medium-r-*-*-11-*-*-*-*-*-*-*" , "-nb", "#1b1b1b", "-nf", "#a5caef", "-sb", "#1b1b1b", "-sf", "#e8e8e8", NULL };
static const char *termcmd[]  = { "urxvtc", NULL };
static const char *chrome[] = { "google-chrome-stable", NULL };
static const char *chromium[] = { "chromium", NULL };
static const char *dwb[] = { "dwb", NULL };
static const char *mail[] = { "thunderbird", NULL };
static const char *files[] = { "thunar", NULL };
static const char *ranger[] = { "urxvtc", "-title", "ranger", "-e", "ranger", NULL };
static const char *pidgin[] = { "pidgin", NULL };
static const char *text[] = { "gvim", NULL };
static const char *ncmpcpp[] = { "urxvtc" , "-title", "ncmpcpp", "-e", "ncmpcpp", NULL };
static const char *vim[] = { "urxvtc" , "-title", "vim", "-e", "vim", NULL };
static const char *mpdpause[] = { "ncmpcpp", "toggle", NULL };
static const char *mpdstop[] = { "ncmpcpp", "stop", NULL };
static const char *mpdnext[] = { "ncmpcpp", "next", NULL };
static const char *mpdprev[] = { "ncmpcpp", "prev", NULL };
static const char *volup[] = { "amixer", "-q", "sset", "'Master'", "5%+", NULL };
static const char *voldown[] = { "amixer", "-q", "sset", "'Master'", "5%-", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ControlMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ControlMask,             XK_c, spawn,          {.v = chrome } },
	{ MODKEY|ControlMask,		  XK_d, spawn,		{.v = dwb } },
	{ MODKEY|ControlMask,             XK_f, spawn,          {.v = files } },
	{ MODKEY|ControlMask,             XK_p, spawn,          {.v = pidgin } },
	{ MODKEY|ControlMask,             XK_m, spawn,          {.v = mail } },
	{ MODKEY|ControlMask,		  XK_t, spawn,		{.v = text } },
    { MODKEY|ControlMask,           XK_n, spawn,    {.v = ncmpcpp} },
    { MODKEY|ControlMask,           XK_r, spawn,    {.v = ranger} },
    { MODKEY|ControlMask,           XK_v, spawn,    {.v = vim } },
	{ MODKEY,			XK_Down,spawn,		{.v = mpdpause } },
	{ MODKEY,			XK_Up,  spawn,		{.v = mpdstop } },
	{ MODKEY,			XK_Right, spawn,		{.v = mpdnext } },
	{ MODKEY,			XK_Left,   spawn,	{.v = mpdprev } },
	{ 0	,			XF86XK_AudioRaiseVolume, spawn, {.v = volup } },
        { 0	,			XF86XK_AudioLowerVolume, spawn, {.v = voldown } },	
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,			XK_d,	   incnmaster,	   {.i = -1 } },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	TAGKEYS(                        0x26,                      0)
	TAGKEYS(                        0xe9,                      1)
	TAGKEYS(                        0x22,                      2)
	TAGKEYS(                        0x27,                      3)
	TAGKEYS(                        0x28,                      4)
	TAGKEYS(                        0xa7,                      5)
	TAGKEYS(                        0xe8,                      6)
	TAGKEYS(                        0x21,                      7)
	TAGKEYS(                        0xe7,                      8)

	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
