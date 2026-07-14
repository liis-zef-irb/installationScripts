# Configure folders in epics base
echo "SUPPORT=$SUPPORT" >> $EPICS_BASE/configure/RELEASE
echo '-include $(TOP)/configure/SUPPORT.$(EPICS_HOST_ARCH)' >> $EPICS_BASE/configure/RELEASE
echo "EPICS_BASE=$EPICS_BASE" >> $EPICS_BASE/configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE' >> $EPICS_BASE/configure/RELEASE
echo '-include $(TOP)/configure/EPICS_BASE.$(EPICS_HOST_ARCH)' >> $EPICS_BASE/configure/RELEASE

# Clone and prepare synapps modules chosen in synApps_libi.txt
scp ./assemble_synApps ${EPICS_ROOT}
scp ./synApps_libi.txt ${EPICS_ROOT}
cd ${EPICS_ROOT}
chmod +x assemble_synApps
perl assemble_synApps --config=synApps_libi.txt

# Build synApps
sudo apt-get install libtirpc-dev re2c -y
cd ${SUPPORT}
make


echo "================================DONE=========================="
