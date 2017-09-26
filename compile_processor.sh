#!/bin/bash

if [ $#==1 ] ; then 
	PROJECTNAME=MyProcessor
else
	PROJECTNAME=$1 Processor
fi

if [ -a "CMakeLists.txt"  ] ; then
	echo "Already have CMakeList"
else
	echo "no CMakeList"
	cp $ILCSOFT/Marlin/v01-09/examples/mymarlin/CMakeLists.txt ./
	sed -i "9c\ PROJECT( ${PROJECTNAME} )" CMakeLists.txt
	sed -i '58c\ ADD_DEFINITIONS( "-Wall -ansi -pedantic -std=gnu++11" )' CMakeLists.txt
	sed -i '59c\ ADD_DEFINITIONS( "-Wno-long-long" )' CMakeLists.txt
	sed -i '31a\ FIND_PACKAGE( ROOT REQUIRED )' CMakeLists.txt
	sed -i '32a\ INCLUDE_DIRECTORIES( ${ROOT_INCLUDE_DIRS} )' CMakeLists.txt
	sed -i '33a\ LINK_LIBRARIES( ${ROOT_LIBRARIES} )' CMakeLists.txt
	sed -i '34a\ FIND_PACKAGE( LCIO REQUIRED )' CMakeLists.txt
	sed -i '35a\ INCLUDE_DIRECTORIES( ${LCIO_INCLUDE_DIRS} )' CMakeLists.txt
	sed -i '36a\ LINK_LIBRARIES( ${LCIO_LIBRARIES} )' CMakeLists.txt

	if [ -d "build"  ] ; then
		echo "Already have  --build-- filter to compile"
	else
		echo "no build filter"
		mkdir build 
	fi
fi

echo 

if [ -d "src"  ] ; then
	echo "Already have  --src-- filter with the source file"
else
	echo "no source filter, mkdir new src filter"
	mkdir src 
	if [ -a *.cc  ] ; then
		echo "Already have source file, move to src filter"
		mv *.cc ./src
	else
		echo "no source file, stop"
		exit
	fi
fi

echo 

if [ -d "include"  ] ; then
	echo "Already have  --include-- filter with the header file"
else
	echo "no header filter"
	mkdir include
	if [ -a *.h  ] ; then
		echo "Already have header file, move to head filter"
		mv *.h ./include
	else
		echo "no head file, stop"
		exit
	fi
fi

echo 

cd ./build

if [ -a "make.output"  ] ; then
	rm make.output
fi

echo "begin to config"
echo 
cmake -C $ILCSOFT/ILCSoft.cmake ..    &> make.output                                                                 
wait
echo "begin to make"
echo 
make &> make.output
wait
echo "begin to make install"
echo 
make install &> make.output
ERRORMESSAGE=$(grep "error" -irn ./make.output)
echo "check the error message"
echo 
echo ${ERRORMESSAGE} 
echo "end"

cd ../


