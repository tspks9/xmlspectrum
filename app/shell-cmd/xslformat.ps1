#!/bin/bash

# syntax-highlight and color source code files for
# xslt produces also an index html page with hyperlinks
# for global templates, functions and params/variables
#
# requires Saxon XSLT 2.0 processor (replace SAXONJAR below)

SAXONJAR="/Users/philipfearon/Applications/SaxonHE9-6-0-2J/saxon9he.jar"
# entry point is XMLSpectrum's highlight-file xsl stylesheet:
XMLSPECTRUM=$(dirname $0)/../xsl/highlight-file.xsl

# first arg must be the source file path

if [[ $# -eq 0 ]]
    then
        echo "no source file name"
elif [[ $1 == '-?' ]]
    then
        :
elif [[ $1 == /* ]]
    then
    relpath=$1
else
    relpath=$(pwd)/$1
fi

if [[ $# -eq 0 || $1 == '-?' ]]
    then
        echo "XMLSpectrum: code higlighter and formatter"
        echo ""
        echo "Usage:"
        echo "xslprint.sh source_file_path [params]"
        echo "params: param=value"
        java -jar $SAXONJAR -xsl:$XMLSPECTRUM -it:main sourcepath=?
    elif [ -f $relpath ]
    then
        filename=$(basename $1)
        newpath=$(dirname $relpath)/xmsxsl-out
        java -jar $SAXONJAR -xsl:$XMLSPECTRUM -it:main sourcepath=$relpath output-path=$newpath output-method=text $2 $3 $4 $5 $6 $7 $8 $9
        newfilepath=$newpath/$filename.text
        open $newfilepath
    else
        echo "file not found: $(pwd)/$1"
fi