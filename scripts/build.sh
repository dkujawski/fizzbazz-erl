#!/bin/bash 
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJ_DIR="$( cd "$( dirname "${THIS_DIR}" )" && pwd )"
EBIN=${PROJ_DIR}/ebin
INCL=${PROJ_DIR}/include
erlc -o ${EBIN} -I ${INCL} ${PROJ_DIR}/src/*.erl

