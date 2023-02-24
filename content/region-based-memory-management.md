Title: Region Based Memory Management
Author: Todd Gaunt
Created: 2019-03-10
Updated: 2019-04-25
Updated: 2020-12-06
Updated: 2022-03-03
Tag: Programming
Tag: C
=== markdown ===

A simple but effective memory management strategy for computer programs is
using memory regions. Regions are great when many objects must be allocated
that share a lifetime, but must outlive the stack frame they were created in.
To explain what a region is: the idea is that rather than using the general
program heap using `malloc` in C or `new` in C++, memory is instead to be
allocated like a stack from a large, fixed-size chunk of memory. Once the chunk
has been fully allocated from, a new chunk can be allocated and set to point to
the old chunk in order to keep track of it for later deallocation. Then, any
allocations afterwards can use the newly allocated chunk until it too is
exhausted of space to allocate from. These steps can be repeated, forming a
linked list of chunks in what can be considered a single region. The following
ASCII diagram illustrates this:

```
[4096 bytes] -> [4096 bytes] -> [4096 bytes] -> NULL
(256 used)      (4034 used)     (3056 used)
^^^^^^^^^^^^
Current Region
```

The benefit of allocating memory this way is that in the end the only things
that must be deallocated are the chunks, and not the individual objects
allocated within those chunks. Since a linked list of the chunks is
maintained, deallocating is as simple as traversing the list and releasing the
chunks along the way.

The key is to make chunks large enough to be allocated from multiple times
without needing to create new chunks. The best size for a chunk is dependent on
the program. If a chunk size too small is used, then the advantage of
allocations from a region being contiguous in memory is lost, and performance
that would be gained from reducing the number of calls to `malloc` or `new` is
lost due to the frequent need to allocate new chunks that may only serve for a
single allocation. If chunks are too large though, memory risks being over-allocated
if the region is long-lived and under-allocated from.

Since a region behaves like a stack-allocater, once any memory is allocated
from a region it cannot be deallocated until the entire region is deallocated
(or at least the chunk that the memory was allocated from). This restriction
limits the practical use of region based memory to programs that use data
structures that are allocated and share a lifetime together. An example of such
a program is a compiler. A compiler needs to parse through a file, allocating
memory of the abstract syntax tree being built. All objects allocated within
the tree tend to stick around for the lifetime of the compiler, and usually end
up deallocated at the very end of the process. This allows for easier and
faster memory management for programs that suit this paradigm.
