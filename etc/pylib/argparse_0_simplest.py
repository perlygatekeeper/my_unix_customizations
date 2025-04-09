#!/opt/local/bin/python 
import argparse
parser = argparse.ArgumentParser()
parser.parse_args()

# Simplest
# $ python prog.py
# $ python prog.py --help
# usage: prog.py [-h]
# 
# options:
#       -h, --help  show this help message and exit
#
# $ python prog.py --verbose
# usage: prog.py [-h]
# prog.py: error: unrecognized arguments: --verbose
#
# $ python prog.py foo
# usage: prog.py [-h]
# prog.py: error: unrecognized arguments: foo
