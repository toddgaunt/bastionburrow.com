Title: Region based memory management
Author: Todd Gaunt
Created: 2019-03-10
Updated: 2019-04-25
Updated: 2020-12-06
Tag: Programming
Tag: C
=== markdown ===

A simple but effective way to manage memory in a computer program is using
memory regions. These regions are great when many small allocations must be
made that have a short lifetime, but must outlive the stack frame they were
created in.  The idea is that rather than using a heap with a general purpose
heap allocator, similar to `malloc` in C and `new` in C++, memory is allocated
more like a stack from a large, fixed-size chunk of memory.  Once the chunk has
been fully allocated from, a new chunk can be allocated and set to point to the
old chunk to keep track of for later deallocation. Then, any allocations
afterwards can use the newly allocated chunk until it too is exhausted of space
to allocate from. These steps can be repeated, forming a linked list of chunks
in what can be considered a single region. The following ASCII diagram
illustrates this:

```
[4096 bytes] -> [4096 bytes] -> [4096 bytes] -> NULL
(256 used)      (4034 used)     (3056 used)
^^^^^^^^^^^^
Current Region
```

The benefit of allocating memory this way is that in the end the only things
that must be deallocated are the chunks. Since a linked list of the chunks is
maintained, deallocating is as simple as traversing the list and releasing the
chunks along the way.

The key is to make chunks large, large enough to be allocated from multiple
times without needing to create new chunks. The best size for a chunk is
dependent on the program. If a chunk size too small is used, then the advantage
of allocations from a region being contiguous in memory is lost, and
performance that would be gained from reducing the number of calls to `malloc`
or `new` is lost due to the frequent need to allocate new chunks that may only
serve for a single allocation. If chunks are too large though, a lot of memory
may be wasted if new regions or chunks are being allocated before the entire
thing gets used.

Since a region behaves like an explicit stack, once any memory is allocated
from a region it cannot be deallocated until the entire region is deallocated,
or at least the chunk that the memory was allocated from. This restricts
practical use of region based memory to short-lived subroutines that simply
need to burn through memory and don't need to actively recycle it during the
process. For this use case though regions are perfect.
