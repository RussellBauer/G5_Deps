#-----------------------------------------------------------------------------
# Put the sub directory name here so it can be used later in the file.
# Set up paths for the module according to the definitions in Makefile.global.
#-----------------------------------------------------------------------------
ModuleName += protobuf-2.3.0


#-----------------------------------------------------------------------------
# Define the dependent modules here. Use the directory name of modules
#-----------------------------------------------------------------------------
BUILD_DEP_MODULE += 


#-----------------------------------------------------------------------------
# Headers and libs which will finally be copied to the toolchain dir.
#
# EX_INCLUDE_FILES - header files which will be exported to toolchain dir.
# 					 
# EX_LIBRARY_FILES - lib files which will be exported to toolchain dir.
#
# ex: EX_INCLUDE_FILES = ./$(ModuleName)/watchdog.h # specify the path!
#	                                 
# - These files will be copied into the local dir during 'make build',
# 		headers  : ./$(TARGET)/include/ 	# $(TARGET) is defined in 
#     	libs     : ./$(TARGET)/lib		    # Makefile.global
#
# - Then Makefile will copy all the files under ./$(TARGET) to
# 	  	headers : $(TARGET_PREFIX)/include/
#     	libs    : $(TARGET_PREFIX)/lib/
#
# EX_TC_MODE_FILES - files which will be set mode bits via 'chmod'.
#
# EX_TC_MODE_LIST  - the mode bits.
# 
# ex: EX_TC_MODE_FILES += $(LIB_FILES), $(HEADER_FILES)
#     EX_TC_MODE_LIST += 755, 644
#	  # use ',' to seperate different files for different mode bits.
#	  # specify the path!
#-----------------------------------------------------------------------------
INS_DIR = ./install

INC_DIR = include
EX_INCLUDE_FILES += ./${INS_DIR}/${INC_DIR}/*

LIB_DIR = lib
EX_LIBRARY_FILES += ./${INS_DIR}/${LIB_DIR}/libproto*.so*

EX_TC_MODE_FILES +=
EX_TC_MODE_LIST +=

#-----------------------------------------------------------------------------
# the binray file which will be installed to the root file system.
# 
# EX_ROOTFS_FILES - the binary files to be copied to root filesystem.
# EX_ROOTFS_DIRS   - the path where the binary file will be installed.
# 
# ex: EX_ROOTFS_FILES += $(BIN_FILES),
# 	  EX_ROOTFS_FILES += $(STARTUP_FILES)
#     EX_ROOTFS_DIRS   = usr/sbin, etc/sysapps_script  
#     # the final character could not be '/' !
#	  # use ',' to seperate different files to different places.
#	  # specify the path!
#	 
# During 'make install'
# $(BIN_FILES) will be copied to
# 1.   ./$(ROOTFS_DIR)/usr/sbin            		
# 2.   $(SYSAP_INSTALL_PATH)/usr/sbin 	   
# $(STARTUP_FILES) will be copied to 
# 1.   ./$(ROOTFS)/etc/sysapps_script	   		
# 2.   $(SYSAP_INSTALL_PATH)/etc/sysapps_script	
#
# EX_RF_MODE_FILES - files which will be set mode bits via 'chmod'.
# EX_RF_MODE_LIST  - the mode bits.
#
# ex: EX_RF_MODE_FILES += $(BIN_FILES), $(DATA_FILES)
#     EX_RF_MODE_LIST += 755, 644
#	  # use ',' to seperate different files for different mode bits.
#	  # specify the path!
#-----------------------------------------------------------------------------
INS_DIR = ./install

LIB_DIR = lib
LIB_FILES += ./${INS_DIR}/${LIB_DIR}/libproto*.so*

BIN_DIR = bin
BIN_FILES += ./${INS_DIR}/${BIN_DIR}/*

STARTUP_DIR = 
STARTUP_FILES +=

EX_ROOTFS_FILES += $(LIB_FILES), $(BIN_FILES)
EX_ROOTFS_DIRS += $(LIB_DIR), $(BIN_DIR)

EX_RF_MODE_FILES +=
EX_RF_MODE_LIST +=

#-----------------------------------------------------------------------------
# Get the global environment data if not passed on.
# The Makefile.global is generated during make bootstrap 
# from Deploy/dat/enrivonment.dat.
#-----------------------------------------------------------------------------
RelRoot = ${PWD}/../../..
ifndef PRJROOT
	export PRJROOT = ${RelRoot}
	include ${PRJROOT}/Deploy/dat/Makefile.global
endif
include ${PRJROOT}/Deploy/dat/Makefile.coverity

#-----------------------------------------------------------------------------
# Include configuration data if needed.
# There are 3 configuration files in ${PRJROOT}/Deploy/dat/.
#   	Makefile.bootldr.config - some settings for boot loader
#   	Makefile.kernel.config  - some settings for kernel
#   	Makefile.sysapps.config - some settings for applications or drivers
#-----------------------------------------------------------------------------
include ${PRJROOT}/Deploy/dat/Makefile.sysapps.config
include ${PRJROOT}/Deploy/dat/Makefile.buildenv

#-----------------------------------------------------------------------------
# The default make options, it will export the specific headers and libs,
# then build and install the module if needed.
#-----------------------------------------------------------------------------
all: build install
libs: build install

#-----------------------------------------------------------------------------
# Build the module, and generate and install files for toolchains.
# For Open source libraries, install to the local dir "$(PWD)/$(TARGET)"
# by setting --prefix="$(PWD)/$(TARGET)", then Makefile will automatically 
# install to $(TARGET_PREFIX) 
#-----------------------------------------------------------------------------

build: build_dep nodep 

nodep: $(ModuleName)/Makefile
	make -C $(ModuleName)
	make -C $(ModuleName) install
	echo "Build of $(ModuleName) complete"
	$(call build_func)
	test -z "${TARGET_PREFIX}/bin" || mkdir -p ${TARGET_PREFIX}/bin
	cp -af $(PWD)/${INS_DIR}/bin/protoc ${TARGET_PREFIX}/bin/protoc

$(ModuleName)/Makefile:
	cd ${ModuleName};\
	./configure --host=${TARGET} \
		CC=${CROSS_COMPILE}gcc \
		--build=i686-pc-linux-gnu \
		--prefix=$(PWD)/${INS_DIR} \
		--with-protoc=/usr/local/bin/protoc ;

#-----------------------------------------------------------------------------
# Check build dependency modules
#-----------------------------------------------------------------------------
build_dep:
	$(call build_dep_func)


#-----------------------------------------------------------------------------
# make install is used to install files for root file system.
# It will
# 1. create files in local dir $(ROOTFS_DIR).
# 2. copy files under $(ROOTFS_DIR) to the real dir $(SYSAP_INSTALL_PATH).
#-----------------------------------------------------------------------------
install: uninstall
	$(call install_func)

#-----------------------------------------------------------------------------
# Clean all generated file or result, including configuration data.
# After this, there would be only source
#-----------------------------------------------------------------------------
cleanall: clean uninstall
	if [ -f $(ModuleName)/Makefile ]; then \
	   make -C $(ModuleName) distclean; \
	fi	
	rm -rf ${INS_DIR}
	$(call cleanall_func)


#-----------------------------------------------------------------------------
# Clean module and clean files for toolchains.
# make clean is corresponding to make build.
#-----------------------------------------------------------------------------
clean: 
	if [ -f $(ModuleName)/Makefile ]; then \
	   make -C $(ModuleName) clean; \
	 fi	
	$(call clean_func)


#-----------------------------------------------------------------------------
# Clean files for root file systems.
# make uninstall is corresponding to make install
#-----------------------------------------------------------------------------
uninstall:
	$(call uninstall_func)

exported_includes:
	echo done
