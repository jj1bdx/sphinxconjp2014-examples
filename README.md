# LaTeX documentation example for SphinxCon JP 2014

## System requirements for the document generation

* [Sphinx](http://sphinx-doc.org/)
    * Tested on Sphinx Version 1.2.3
    * Tested on OS X 10.10 and FreeBSD 10.1-PRERELEASE
* [TeX Live](https://www.tug.org/texlive/)
    * FreeBSD: [Port print/texlive-full](http://www.freshports.org/print/texlive-full/)
    * OS X: [MacTeX](https://www.tug.org/mactex/) (Use MacTeX-2014)

## System requirements for testing the code

* [Python 3](http://www.python.org/)
* [Erlang/OTP](http://www.erlang.org)

## How to compile

    cd doc-src/
    make clean html latexpdfja
    # open _build/html/index.html for the HTML docs
    # open _build/pdf/LaTeXtestdocforSphinxConJP2014.pdf for the PDF docs

## License

Dual-licensed under The MIT License and CC-BY-4.0.

## Author

Kenji Rikitake

