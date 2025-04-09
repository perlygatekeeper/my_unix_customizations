#!/opt/local/bin/python 

parser = argparse.ArgumentParser()
parser.add_argument('infile',  nargs='?', type=argparse.FileType('rb'), default=sys.stdin)
parser.add_argument('outfile', nargs='?', type=argparse.FileType('wb'),  default=sys.stdout)
