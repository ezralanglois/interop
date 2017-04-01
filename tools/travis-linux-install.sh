#!/bin/bash

lsb_release -a

PYTHON_VERSION_NUM=$1
if [ -z "$PYTHON_VERSION_NUM" ] ; then
    PYTHON_VERSION_NUM="2.7"
fi

# http://stackoverflow.com/questions/33196136/travis-ci-update-cmake-using-the-packages-cache
CMAKE_URL="http://www.cmake.org/files/v3.4/cmake-3.4.3-Linux-x86_64.tar.gz"
mkdir $HOME/cmake && travis_retry wget --quiet -O - ${CMAKE_URL} | tar --strip-components=1 -xz -C $HOME/cmake
export PATH=${HOME}/cmake/bin:${PATH}


# How To: https://conda.io/docs/travis.html
if [ ! -e $HOME/miniconda_${$PYTHON_VERSION_NUM} ]; then
    if [[ "$PYTHON_VERSION_NUM" == "2.7" ]]; then
        wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh;
    else
        wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
    fi
    bash miniconda.sh -b -p $HOME/miniconda_${$PYTHON_VERSION_NUM}
    export PATH="$HOME/miniconda_${$PYTHON_VERSION_NUM}/bin:$PATH"
    hash -r
    conda config --set always_yes yes --set changeps1 no
    conda update -q conda
    conda info -a

    conda create -q -n test-environment python=$PYTHON_VERSION_NUM numpy
fi

if [ ! -e $HOME/NUnit-2.6.4/bin/nunit.framework.dll ]; then
    travis_retry wget https://github.com/nunit/nunitv2/releases/download/2.6.4/NUnit-2.6.4.zip
    unzip NUnit-2.6.4.zip -d $HOME
fi





