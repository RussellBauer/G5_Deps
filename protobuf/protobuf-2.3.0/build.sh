#!/bin/bash

export RPM_BUILD_PATH="/usr/src/redhat/BUILD/protobuf-"
export RPM_BUILD_PATH_DEVEL="/usr/src/redhat/BUILD/protobuf-devel-"
export _Version="2.3.0"
export PROTOBUF_BUILD_PATH="/usr/src/redhat/BUILD/protobuf"

Rpm_Build()
{
	RPM_BUILD_PATH=$RPM_BUILD_PATH$_Version
	test -e $RPM_BUILD_PATH && rm -rf $RPM_BUILD_PATH
	mkdir -p $RPM_BUILD_PATH/usr/lib
	RPM_BUILD_PATH_DEVEL=$RPM_BUILD_PATH_DEVEL$_Version
	test -e $RPM_BUILD_PATH_DEVEL && rm -rf $RPM_BUILD_PATH_DEVEL
	mkdir -p $RPM_BUILD_PATH_DEVEL/usr/include
	mkdir -p $RPM_BUILD_PATH_DEVEL/usr/bin
	test -e $PROTOBUF_BUILD_PATH && rm -rf $PROTOBUF_BUILD_PATH
	chmod +x configure
	./configure --prefix=/usr
	make clean
	make 
	make DESTDIR=$PROTOBUF_BUILD_PATH install
	cp -rf $PROTOBUF_BUILD_PATH/usr/lib/* $RPM_BUILD_PATH/usr/lib/
	cp -rf $PROTOBUF_BUILD_PATH/usr/bin/* $RPM_BUILD_PATH_DEVEL/usr/bin/
	cp -rf $PROTOBUF_BUILD_PATH/usr/include/* $RPM_BUILD_PATH_DEVEL/usr/include/
	rpmbuild -bb protobuf.spec
	rpmbuild -bb protobuf_src.spec
	mv /usr/src/redhat/RPMS/i386/protobuf* ../../output/rpm
}

if [ "$1" = "rpm" ]; then
	echo "Bulid protobuf RPMs..."
	Rpm_Build
elif [ "$1" = "clean" ];then
	echo "Clean protobuf..."
	rm -rf ../../output/rpm/protobuf*
else
	echo "Build protobuf..."
	./configure --prefix=/usr
	make 
fi
