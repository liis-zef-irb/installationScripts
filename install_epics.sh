# Location of EPICS, feel free to change
EPICS_ROOT=${HOME}/EPICS

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
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install build-essential cmake -y
cd ${EPICS_BASE}
make


echo "================================DONE=========================="
