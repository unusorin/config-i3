#!/usr/bin/env bash

for f in resources/wallpapers/*.jpg
do
	convert "${f%.jpg}.jpg" "${f%.jpg}.png"
	rm $f
done
