# necmark

[![Build Status](https://travis-ci.org/ConstNW/necmark.svg?branch=master)](https://travis-ci.org/ConstNW/necmark)

necmark is a haxe/neko library that wraps subset of cmark C library (that is one of reference implementations of CommonMark).

## Features

- no need to install ``libcmark``
- supported output: HTML, XML, CommonMark, man, LaTeX
- supported options: ``CMARK_OPT_UNSAFE``, ``CMARK_OPT_NOBREAKS``,
  ``CMARK_OPT_HARDBREAKS``, ``CMARK_OPT_SOURCEPOS``, ``CMARK_OPT_SMART``
- safe HTML output is on by default (like in ``libcmark``)

## Installation

    haxelib install necmark
or

    haxelib git https://github.com/ConstNW/necmark

### Usage

```haxe
var src = "Hello World!";
var n = new necmark.Necmark(src);
var out = n.render(ncrHtml(necmark.Necmark.RENDER_OPT_UNSAFE));
```

[more examples](https://github.com/ConstNW/necmark/tree/master/test)
