#!/opt/local/bin/python
# from https://docs.python.org/3/library/argparse.html#quick-links-for-add-argument
# Quick Links for add_argument()¶
#
# Name        Description                                     Values
# action   Specify how an argument should be handled                 'store', 'store_const', 'store_true', 'append', 'append_const',
#                                                                    'count', 'help', 'version'
# choices  Limit values to a specific set of choices                 ['foo', 'bar'], range(1, 10), or Container instance
# const    Store a constant value
# default  Default value used when an argument is not provided       Defaults to None
# dest     Specify the attribute name used in the result namespace
# help     Help message for an argument
# metavar  Alternate display name for the argument as shown in help
# nargs    Number of times the argument can be used                  int, '?', '*', or '+'
# required Indicate whether an argument is required or optional      True or False
# type     Automatically convert an argument to the given type       int, float, argparse.FileType('w'), or callable function
