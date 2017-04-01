#!/usr/bin/env bash

sw_vers

PYTHON_VERSION_NUM=$1
if [ -z "$PYTHON_VERSION_NUM" ] ; then
    PYTHON_VERSION_NUM="2.7"
fi


brew update
brew list
brew unlink cmake
brew install cmake
brew install swig
brew install doxygen
brew install mono

if [ ! -e $HOME/miniconda_${$PYTHON_VERSION_NUM} ]; then
    # How To: https://conda.io/docs/travis.html
    if [[ "$PYTHON_VERSION_NUM" == "2.7" ]]; then
        wget https://repo.continuum.io/miniconda/Miniconda2-latest-MacOSX-x86_64.sh -O miniconda.sh;
    else
        wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh;
    fi

    bash miniconda.sh -b -p $HOME/miniconda_${PYTHON_VERSION_NUM}
    export PATH="$HOME/miniconda_${PYTHON_VERSION_NUM}/bin:$PATH"
    hash -r
    conda config --set always_yes yes --set changeps1 no
    conda update -q conda
    conda info -a

    conda create -q -n test-environment python=$PYTHON_VERSION_NUM numpy
fi

