#!/bin/sh

#	sinewave.sh
#	show a sinewave
#	Language: shell, bc


h=11

while [ $h -gt -10 ]; do

	h = `expr $h -1` 

	x = 1

	while [ $x -lt 40 ]; do

		x = `expr $x + 1`

		sin = `echo "10*s($x/4)" | bc -l`
		err = `echo "$h - $sin" | bc`
		header = `echo $err | sed 's/-//'`
		cl = `echo $header | cut -c 1`

		if [ $cl = "." ]; then 
			echo -n "X "
		else
			echo -n "  "
		fi
	done
	echo ""
done


