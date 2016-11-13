#!/bin/sh

latex $1".tex" && dvips $1".dvi" && ps2pdf $1".ps"
