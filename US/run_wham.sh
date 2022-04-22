#!/bin/bash
wham 13.2 32.7 39 0.0001 300.0 0 wham.in wham.out
cat wham.out | awk '{print$1,$2}' > pmf-40.dat
