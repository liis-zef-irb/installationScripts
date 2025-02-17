sudo apt-get install git-all build-essential cmake

mkdir $HOME/EPICS
cd $HOME/EPICS/
git clone --recursive https://github.com/epics-base/epics-base.git base
nano ~/.bashrc		add:	export EPICS_ROOT=${HOME}/EPICS
				export EPICS_BASE=${EPICS_ROOT}/base
				export EPICS_HOST_ARCH=$(${EPICS_BASE}/startup/EpicsHostArch)
				export PATH=${EPICS_BASE}/bin/${EPICS_HOST_ARCH}:${PATH}
				export SUPPORT=${EPICS_ROOT}/support
source ~/.bashrc
cd ${EPICS_BASE}
sudo make

echo "SUPPORT=$SUPPORT" > configure/RELEASE
echo '-include $(TOP)/configure/SUPPORT.$(EPICS_HOST_ARCH)' >> configure/RELEASE
echo "EPICS_BASE=$EPICS_BASE" >> configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE' >> configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE.$(EPICS_HOST_ARCH)' >> configure/RELEASE
echo "" >> configure/RELEASE
echo "" >> configure/RELEASE

cd ${EPICS_ROOT}
wget https://raw.githubusercontent.com/liis-zef-irb/installationScripts/refs/heads/main/assemble_synApps
perl assemble_synApps
cd support
make
