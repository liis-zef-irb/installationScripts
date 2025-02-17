sudo apt-get install git-all build-essential cmake

mkdir $HOME/EPICS
cd $HOME/EPICS/
git clone --recursive https://github.com/epics-base/epics-base.git base

echo "export EPICS_ROOT=${HOME}/EPICS" >> ~/.bashrc
echo "export EPICS_BASE=${EPICS_ROOT}/base" >> ~/.bashrc
echo "export EPICS_HOST_ARCH=$(${EPICS_BASE}/startup/EpicsHostArch)" >> ~/.bashrc
echo "export PATH=${EPICS_BASE}/bin/${EPICS_HOST_ARCH}:${PATH}" >> ~/.bashrc
echo "export SUPPORT=${EPICS_ROOT}/support" >> ~/.bashrc
source ~/.bashrc

cd ${EPICS_BASE}
make

echo "SUPPORT=$SUPPORT" >> configure/RELEASE
echo '-include $(TOP)/configure/SUPPORT.$(EPICS_HOST_ARCH)' >> configure/RELEASE
echo "EPICS_BASE=$EPICS_BASE" >> configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE' >> configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE.$(EPICS_HOST_ARCH)' >> configure/RELEASE

cd ${EPICS_ROOT}
wget https://raw.githubusercontent.com/liis-zef-irb/installationScripts/refs/heads/main/assemble_synApps
perl assemble_synApps
cd support
make
