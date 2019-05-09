static const char norm_fg[] = "#f8f8f8";
static const char norm_bg[] = "#1f2022";
static const char norm_border[] = "#585858";

static const char sel_fg[] = "#f8f8f8";
static const char sel_bg[] = "#67b11d";
static const char sel_border[] = "#f8f8f8";

static const char urg_fg[] = "#f8f8f8";
static const char urg_bg[] = "#f2241f";
static const char urg_border[] = "#f2241f";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
