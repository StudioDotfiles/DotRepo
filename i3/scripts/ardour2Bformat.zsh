#!/bin/zsh

# ardour2Bformat.zsh Copyright (C) 2012 Bart Brouns
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

if [[ $#@ < 3 ]]; # check number of arguments
then
	echo "Converts a folder with A-format recordings done in Ardour to B-format files."
	echo "If you don't have a ambisonic microphone, you don't need this :)"
	echo
	echo "Usage: zsh ardour2Bformat.zsh <options> <config file> <input dir> <output dir>"
	echo
	echo "Options:"
	echo "  Display this text:     --help"
	echo "  Stereo input files:    --stin"
	echo "  Highpass filter:       --hpf <frequency>"
	echo "  B format standard:     --fuma, --sn3d, --n3d"
	echo "  B format inversion:    --invx, --invy, --invz"
	echo "  Endfire mode:          --endf"
	echo "  Output file type:      --amb, --caf, --wav"
	echo "The default options are --fuma, --amb."
	echo
	echo "see tetrafile --help for more info, except this script uses input dir and output dir instead of input file(s) and output file"
	echo
	echo
	echo "Ardour should record 4-channel tracks into for example:"
	echo "	audio1-7%a.wav	audio1-7%b.wav	audio1-7%c.wav	audio1-7%d.wav"
	echo "Sometimes Ardour records them to other numbers, for example:"
	echo "	audio1-7%a.wav 	audio1-7%b.wav	udio1-7%c.wav	audio1-6%d.wav"
	echo
	echo "This script works around that."
	# It takes all files with names like  TrackName-Number-%a.wav
	# Where TrackName is the name of the Ardour track the audio was recorded on
	
	# It then checks for %b.wav files of the same size and with the same trackname
	# If there are more or less then one, it exits with an explanation
	# If there is exactly one, it goes on to b and c
	
	# then it converts the 4 files (a,b,c and d) into one B-format file
else
	zmodload -F zsh/stat b:zstat # for zstat
	# echo "second last commandline argument (input dir)" $argv[-2]
	mkdir -p -v  $argv[-1] # try to create output dir if it doesnt exists
	
	cd $argv[-2] # go to inut dir
	
	nrFiles=0
	for InputFileA in *<0-9999>%a.wav(.L+56)  #take all filenames with the form Something-Number-%a.wav exclude files of 56 bits and smaller
	do
		#echo #separate the output lines
		TrackNameDashNumber=${InputFileA%%\%a.wav} #remove everything from %a.wav
		#echo TrackNameDashNumber $TrackNameDashNumber
		TrackName=${InputFileA%%-<0-9999>\%a.wav} #remove everything from -Number%a.wav
		#echo TrackName $TrackName
		InputSize=$(zstat +size $InputFileA)
		#echo InputFileA $InputFileA
		#echo InputSize $InputSize
		
		
		InputFile[1]="nothing yet"
		InputFile[2]="nothing yet"
		InputFile[3]="nothing yet"
		
		BtoD[1]=b
		BtoD[2]=c
		BtoD[3]=d
		
		
		for i in {1..3}  # find b,c and d-files
		do
			postfix=$BtoD[$i]
			SearchTrackArray=($TrackName-<0-9999>%$postfix.wav(N)) #All b,c, and d files with the same track name
	
			if (( $#SearchTrackArray )); 
			then # there is at least one candidate file
				for SearchTrack in $TrackName-<0-9999>%$postfix.wav # search them all
				do
					SearchTrackSize=$(zstat +size $SearchTrack)
					#echo SearchTrackSize $SearchTrackSize
					if [[ "$InputSize" == "$SearchTrackSize" ]];
					then #if same size
						#echo InputFile $i $InputFile[$i] 
						if [[ "$InputFile[$i]" == "nothing yet" ]];
						then # if no file candidate yet
							InputFile[$i]=$SearchTrack # appoint a candidate
						else # a candidate track has allready been found
							if [[ "$SearchTrack[1,-7]" == "$TrackNameDashNumber" ]]; 
							then # check if it has the same number
								echo There are two files ending in %$postfix.wav with the same size as	$InputFileA:
								echo $InputFile[$i] and $SearchTrack.
								echo Since it matches the number of $InputFileA, I\'m using				$SearchTrack.
								echo You should check in your .ardour file If that assumtion is correct.
								echo
								InputFile[$i]=$SearchTrack # overwrite the candidate. todo: check if this works in all cases
							else
								echo There are two files ending in %$postfix.wav with the same size as	$InputFileA:
								echo $InputFile[$i] and $SearchTrack.
								echo Since it matches the number of $InputFileA, I\'m using				$InputFile[$i].
								echo You should check in your .ardour file If that assumtion is correct.
								echo 
							fi # check if it has the same number
						fi # if no file candidate yet
					fi #if same size
				done # for SearchTrack in $TrackName-<0-9999>%$postfix.wav
			fi # there is at least one candidate file
	
			if [[ "$InputFile[$i]" == "nothing yet" ]];
			then
				echo There is no file ending in $postfix.wav, with the same size as $InputFileA.
				echo You should check in your .ardour file what is going on.
				echo
				echo exiting...
				exit 1;
			fi
			
		done # for i in {1..3}
		
		# Do the actual work:
		
		echo Processing these files:
		echo $InputFileA $InputFile[1] $InputFile[2] $InputFile[3] 
		echo into $TrackNameDashNumber%a-B-format.wav
		echo
		
		# merge the 4 files into one 
		sndfile-interleave $InputFileA $InputFile[1] $InputFile[2] $InputFile[3] -o /tmp/ardour2Bformat.tmp
		
		# make it B-format
		#echo 	tetrafile $argv[1,-3] /tmp/ardour2Bformat.tmp $argv[-1]/$TrackNameDashNumber%a-B-format.wav
		tetrafile $argv[1,-3] /tmp/ardour2Bformat.tmp $argv[-1]/$TrackNameDashNumber%a-B-format.wav
		
	done # for InputFileA in *<0-9999>%a.wav(.L+56)
	
	rm /tmp/ardour2Bformat.tmp

fi	# check number of arguments
exit 0;
