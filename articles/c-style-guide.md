Title: C style guide
Created: 2019-04-20
Updated: 2020-11-04
Tag: C
Tag: Style
Tag: Guide
Tag: Programming
=== markdown ===
# Notice
This is a modification of the style guide provided by suckless.org.

# File Layout
- Comment with LICENSE
- Headers
- Macros
- Types
- Function declarations
    - Include variable names
    - For short files these can be left out
    - Group/order in logical manner
- Global variables
- Function definitions in same order as declarations
- main

# C Features
- Up to C99 without extensions
- POSIX.1-2008
- Declarations should not be mixed with statements
- Loop initial declarations should not used
- C style `/* */` comments should be used, not C++ style `//` comments
- `#if 0 #endif` must be used to comment out code, not `/* */`
- Variadic functions and macros are acceptable, but require safety

# Blocks
- `{` on same line preceded by single space (except functions)
- `}` on own line unless continuing statement (e.g. `if else`)
- Blocks are used for single statements if and only if
    - An inner statement needs a block:

        ```
        for (;;) {
            if (foo) {
                bar;
                baz;
            }
        }
        ```

    * Another branch of the same statement needs a block:

        ``` 
        if (foo) {
            bar;
        } else {
            baz;
            qux;
        }
        ``` 

    * One exception to this rule is nested for loops like below:

        ``` 
        for (i = 0; i < 64; ++i)
        for (j = 0; j < 32; ++j)
        for (k = 0; k < 16; ++k) {
            /* ... do stuff here ... */
        }
        ``` 
    
# Indentation and Line Length
- The maximum line length is 80 columns
- Tabs are used for indentation with a visual width 8-spaces
- An extra indent or two should be used when wrapping lines 
- String literals used in error messages are an exception to these rules:
    - This makes them easy to search for with grep
- Multiline string literals should be continued with `\`

# Functions
* Modifiers and the return type on their own line
* Function name and argument list on the next line
* Opening `{` must be on its own line (functions are special)
* Functions not used outside translation unit must be static

# Variables
* Should be declared as close as possible to initialization/use
* Global variables not used outside translation unit should be static
* In declaration of pointers the * must be touching the variable name, not the type:

    ```
    int *foo;
    ```
    
# Keywords
* Space after `if`, `for`, `while`, and `switch` as these are not function calls
* Space should not be used after the opening `(` and before the closing `)`
* Parentheses must be used with `sizeof`
* `sizeof()` must be written as a function call since it acts like one
* `switch` statements and their cases share the same indentation level
* `switch` cases that FALLTHROUGH should be commented

# Headers
* Include libc/system headers come first alphabetically
    * If order cannot be alphabetical, a comment must explain
* There must be a blank line between system headers and project headers
* When writing and using local headers
    * Include guards must be used
    * Should be included alphabetically

# User Defined Types
* Typedef is not used for structs which have fields meant to be accessed
* Typedef is allowed for opaque types, enums, and error codes
* Type names should be all lowercase

# Handling Errors
* Use Linux style gotos in a function that can fail and must cleanup multiple resources before exiting
* Errors or failures should be returned from early rather than later in nested code:
    * Like so:

        ```
        if (err)
            return;
        ```

    * Instead of:

        ```
        if (success) {
            /* Do stuff */
        } else {
            return;
        }
        ```

# Enums vs #define
* Use enums for values that are grouped semantically and #define otherwise:

    ```
    #define MAXSZ  4096
    #define MAGIC1 0xdeadbeef

    enum {
        DIRECTION_X,
        DIRECTION_Y,
        DIRECTION_Z
    };
    ```
