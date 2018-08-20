#!/home/turner/tools/anaconda3/bin/python

import glob
import sys

l = glob.glob(str(sys.argv[1]))
print('%s %s'%(len(l), sys.argv[1]))