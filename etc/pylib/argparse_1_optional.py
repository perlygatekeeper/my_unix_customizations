#!/opt/local/bin/python 
import argparse
parser = argparse.ArgumentParser()

# -v or --verbosity will take one argument
# -d or --debug is a flag and will take no arguments

parser.add_argument("-v", "--verbosity", help="set  output verbosity")
parser.add_argument("-d", "--debug", help="increase output verbosity",
                    action="store_true")
args = parser.parse_args()
if args.verbose:
    print("verbosity turned on")
