#!/home/turner/tools/anaconda3/bin/python

# grabs a random picture from a given directory then runs pywal on it

# imports
import os
import fnmatch
import random
from subprocess import call

# set directory with the wallpapers
pict_dir = '/cherokee1/turner/pictures/wallpapers/'

# read in the file names in the directory and save to a list
wallpapers = []
for file in os.listdir(pict_dir):
	if fnmatch.fnmatch(file, '*.jpg') or fnmatch.fnmatch(file, '*.png'):
		wallpapers.append(file)

# chose one at random
w = random.randint(0, len(wallpapers))

# generate wal command
command = ['wal', '-q', '-i', '%s%s'%(pict_dir, wallpapers[w])]
# run
call(command)