#!/bin/bash

tassel=${HOME}/software/TASSEL5/run_pipeline.pl

$tassel -Xmx30g -h Gma.kinship.hmp -KinshipPlugin -method Centered_IBS -endPlugin -export Gma_kin -exportType SqrMatrix

perl 05.trans_kin.pl Gma_kin.txt Gma_kin
