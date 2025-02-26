# Location of EPICS, feel free to change
EPICS_ROOT=${HOME}/EPICS

# Location of all installation scripts
SCRIPTS_DIR=$(pwd)

# Install VCOM driver
/bin/bash ./InstallVcomDriver.sh

# Clone base repository from github
mkdir $EPICS_ROOT
cd $EPICS_ROOT
git clone --recursive https://github.com/epics-base/epics-base.git base

# Define enviroment variables for relevant folders
EPICS_BASE=${EPICS_ROOT}/base
EPICS_HOST_ARCH=$(${EPICS_BASE}/startup/EpicsHostArch)
PATH=${EPICS_BASE}/bin/${EPICS_HOST_ARCH}:${PATH}
SUPPORT=${EPICS_ROOT}/support

# Auto-define on reboot
echo "" >> ~/.bashrc
echo "export EPICS_ROOT=${EPICS_ROOT}" >> ~/.bashrc
echo "export EPICS_BASE=${EPICS_BASE}" >> ~/.bashrc
echo "export EPICS_HOST_ARCH=${EPICS_HOST_ARCH}" >> ~/.bashrc
echo "export PATH=${PATH}" >> ~/.bashrc
echo "export SUPPORT=${SUPPORT}" >> ~/.bashrc

# Build epics base
sudo apt-get install build-essential cmake
cd ${EPICS_BASE}
make

# Configure folders in epics base
echo "SUPPORT=$SUPPORT" >> configure/RELEASE
echo '-include $(TOP)/configure/SUPPORT.$(EPICS_HOST_ARCH)' >> configure/RELEASE
echo "EPICS_BASE=$EPICS_BASE" >> configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE' >> configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE.$(EPICS_HOST_ARCH)' >> configure/RELEASE

# Clone and prepare synapps modules chosen in assemble_synapps
scp ${SCRIPTS_DIR}/assemble_synApps ${EPICS_ROOT}/assemble_synApps
cd ${EPICS_ROOT}
chmod +x assemble_synApps
perl assemble_synApps

# Build synApps
#sudo apt-get install libtirpc-dev re2c
cd ${SUPPORT}
make

# Clone LIBI IOCs
cd ${EPICS_ROOT}
git clone git@github.com:liis-zef-irb/IOCs.git

echo "================================DONE=========================="
