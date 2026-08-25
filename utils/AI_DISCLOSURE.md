---
disclosure-default: none
scope: |
  All source, tests, and documentation in this repository are written by hand.
  No model-generated code is committed. Any exception to this will be marked at
  file level with an SPDX-AI-Disclosure header; the absence of such a header means
  that this default applies.
last-updated: 2026-08-25
---

# AI disclosure

This repository follows the
[ai-disclosure convention](https://github.com/ggfevans/ai-disclosure).

The default is set to `none`, as in "I wrote this code myself".

Explaining why is in essence out of scope for this disclosure, but the TL;DR: is two-fold:

1. Coding is my craft; I like it, and I'm quite good at it.
2. I _don't_ like the code LLMs produce, how the theory behind it is lost between iterations, or what repetitive or habitual AI usage does to the wiring of my brain.

For some more context on my take on this, I recommend [this post on Peter Naur's "Programming as Theory Building" essay from 1985](https://cekrem.github.io/posts/programming-as-theory-building-naur/), as well as [these relevant blog posts](https://cekrem.github.io/tags/coding-as-craft/) that also in various ways touch on the topic.

## Exceptions

Any exception is marked on a per-file basis, using the `SPDX-AI-Disclosure:` line tag in a top-of-file comment, with one of the four values from the [W3C AI Content Disclosure](https://www.w3.org/community/ai-content-disclosure/) vocabulary. A file-level tag overrides the repository default. In other words: no tag means the default above applies.

Two things sit outside this scheme entirely and can't be marked per file: dependencies, which I didn't write (and make no claim about), and non-generative tooling such as compilers, type inference, linters, formatters, and automated refactorings, which produce deterministic output (that I read "manually" before committing).

## Contributions

Contributions are welcome, and must include an accurate `SPDX-AI-Disclosure:` header if a model was involved, and _you must understand what you're submitting well enough to defend it in review_.
