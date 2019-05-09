const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#1f2022", /* black   */
  [1] = "#f2241f", /* red     */
  [2] = "#67b11d", /* green   */
  [3] = "#b1951d", /* yellow  */
  [4] = "#4f97d7", /* blue    */
  [5] = "#a31db1", /* magenta */
  [6] = "#2d9574", /* cyan    */
  [7] = "#a3a3a3", /* white   */

  /* 8 bright colors */
  [8]  = "#585858",  /* black   */
  [9]  = "#f2241f",  /* red     */
  [10] = "#67b11d", /* green   */
  [11] = "#b1951d", /* yellow  */
  [12] = "#4f97d7", /* blue    */
  [13] = "#a31db1", /* magenta */
  [14] = "#2d9574", /* cyan    */
  [15] = "#f8f8f8", /* white   */

  /* special colors */
  [256] = "#1f2022", /* background */
  [257] = "#a3a3a3", /* foreground */
  [258] = "#a3a3a3",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
