#!/home/turner/tools/anaconda3/bin/python

# small python tool to list the number of files in a directory

# edit line 1 above for your python (i.e. run 'which python' to get path to your specific python)
# place in /usr/local/bin
#
# to get number of all files in directory:
# how_many
#
# to get number of files of certain type in directory:
# how_many "*.txt"
#
# can also handle multiple command line arguments
# how_many "*.txt" "*.dat" "foo*.sh" 

# alias to hm for easier calling


import glob
import sys

if len(sys.argv) == 1:
	l = glob.glob('*')
	print('%s *'%len(l))

elif len(sys.argv) > 1:
	for arg in sys.argv[1:]:
		l = glob.glob(str(arg))
		print('%s %s'%(len(l), arg))