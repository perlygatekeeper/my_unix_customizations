#!/opt/local/bin/python 
import argparse
parser = argparse.ArgumentParser()

#  help is optional and useful for describing what the argument will be used for
#  type=int  allows for values other than the default of 'str'
#  args is supplied by argparse for free

parser.add_argument("square", help="display a square of a given number",
                            type=int)
args = parser.parse_args()
print(args.square**2)
