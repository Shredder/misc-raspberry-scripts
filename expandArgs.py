#!/usr/bin/env python

import argparse
import itertools
import re
import sys

def parseArgs():
    parser = argparse.ArgumentParser(description='Expand arguments into string')
    parser.add_argument('-g', '--group', type=str, nargs='+', action='append', help='Argument group')
    parser.add_argument('-r', '--reverse', action='store_true', help='Reverse permutation order')
    parser.add_argument('-s', '--separator', type=str, default='', help='Separator when string to expand is not supplied.')
    parser.add_argument('-n', '--newline', action='store_true', help='One argument per line')
    parser.add_argument('string', type=str, nargs='?', help='String to expand')
    args = parser.parse_args()
    if args.string is None and args.group is None:
        parser.print_help()
        sys.exit(0)

    return args

def checkString(expandString, argGroups, separator):
    if expandString is None:
        expandString = separator.join([ '{%d}' % x for x in xrange(len(argGroups)) ])
    return expandString

def main(args):
    argGroups = args.group
    expandString = args.string
    expandString = checkString(expandString, argGroups, args.separator)
    idx = map(int, re.findall('\{(\d+)\}', expandString))
    argGroups = [ argGroups[i] for i in idx ]
    if args.reverse:
        argGroups = reversed(argGroups)

    if args.newline:
        for argCombination in itertools.product(*argGroups):
            if args.reverse:
                print(expandString.format(*reversed(argCombination)))
            else:
                print(expandString.format(*argCombination))
    else:
        for argCombination in itertools.product(*argGroups):
            if args.reverse:
                print(expandString.format(*reversed(argCombination)),)
            else:
                print(expandString.format(*argCombination),)

if __name__ == '__main__':
    main(parseArgs())
