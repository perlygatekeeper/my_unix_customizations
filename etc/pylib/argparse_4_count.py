#!/opt/local/bin/python
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("square", type=int,
                            help="display a square of a given number")
parser.add_argument("-v", "--verbosity", action="count",
                            help="increase output verbosity")
args = parser.parse_args()
answer = args.square**2

# try with 
# $ argparse_4_count.py -h
# $ argparse_4_count.py -v
# $ argparse_4_count.py -vv
# $ argparse_4_count.py -vvv
# $ argparse_4_count.py -vvvv

# bugfix: replace == with >=
if args.verbosity >= 2:
        print(f"the square of {args.square} equals {answer}")
elif args.verbosity >= 1:
        print(f"{args.square}^2 == {answer}")
else:
        print(answer)
