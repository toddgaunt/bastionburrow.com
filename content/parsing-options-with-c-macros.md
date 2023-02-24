Title: Parsing Options with C Macros
Created: 2019-04-20
Updated: 2020-07-29
Tag: Programming
Tag: C
Tag: Parsing
=== markdown ===
There are so many argument parsing libraries for C that I couldn't pick and made my
own. This argument parser fits in a single header file just 25 lines long
and only supports short option arguments. This can be nice for C projects that need
quick and dirty commandline argument support. Also perfect for minimalists that hate
reading and writing.

## C Header

```
/* Argument Parsing Macros for C */
#ifndef ARG_H
#define ARG_H

#define ARG_BEGIN(argv) \
    for (; (argv)[0]; ++(argv)) { \
        if ('-' != (argv)[0][0]) \
            break; \
        (argv)[0] += 1; \
        while ('\0' != (argv)[0][0]) { \
            (argv)[0] += 1; \
            switch ((argv)[0][-1])

#define ARG_END break;}}

/* Terminate the argument list */
#define ARGT(argv) ((argv[1]) = NULL)

/* Retrieve the current flag */
#define ARGF(argv) ((argv)[0][-1])

/* Retrieve the current argument */
#define ARGP(argv) ('\0' == (argv)[0][0] ? (++(argv))[0] : (argv)[0])

#endif
```

## Example

```
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "arg.h"

int
main(int argc, char **argv)
{
    (void)argc;
    int verbose;
    char *arg;
    char *prefix;
    
    argv += 1;
    
    ARG_BEGIN(argv) {
    case 'p': /* Provide path prefix used for all commands */
        arg = ARGP(argv);
        if (!prefix) {
            fprintf(stderr, "No prefix provided for '-p'\n");
            exit(-1);
        }
        prefix = arg;
        break;
    case 'q': /* Quiet flag */
        verbose = 0;
        continue;
    case 'v': /* Verbose flag */
        verbose += 1;
        continue;
    case '-': /* Argument terminal */
        ARGT(argv);
        break;
    default:
        fprintf(stderr, "Invalid option '-%c'\nTry '-h'\n", ARGF(argv));
    } ARG_END;

    if (verbose)
        printf("Verbosity=%d\n", verbose);
}
```
