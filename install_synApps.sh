# Configure folders in epics base
echo "SUPPORT=$SUPPORT" >> configure/RELEASE
echo '-include $(TOP)/configure/SUPPORT.$(EPICS_HOST_ARCH)' >> configure/RELEASE
echo "EPICS_BASE=$EPICS_BASE" >> configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE' >> configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE.$(EPICS_HOST_ARCH)' >> configure/RELEASE

# Clone and prepare synapps modules chosen in assemble_synapps
scp ./assemble_synApps ${EPICS_ROOT}/assemble_synApps
cd ${EPICS_ROOT}
chmod +x assemble_synApps
perl assemble_synApps

# Build synApps
sudo apt-get install libtirpc-dev re2c -y
cd ${SUPPORT}
make


echo "================================DONE=========================="
