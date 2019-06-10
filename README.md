# necmark [![Build Status](https://travis-ci.org/ConstNW/necmark.svg?branch=master)](https://travis-ci.org/ConstNW/necmark)

necmark is bindings to cmark library (CommonMark implementation in C).

Features
--------
- no need to install ``libcmark``
- supported output: HTML, XML, CommonMark, man, LaTeX
- supported options: ``CMARK_OPT_UNSAFE``, ``CMARK_OPT_NOBREAKS``,
  ``CMARK_OPT_HARDBREAKS``, ``CMARK_OPT_SOURCEPOS``, ``CMARK_OPT_SMART``
- safe HTML output is on by default (like in ``libcmark``)
