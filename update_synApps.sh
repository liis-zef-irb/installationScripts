# Clone and prepare synapps modules chosen in synApps_libi
scp ./assemble_synApps ./synApps_libi.txt ${EPICS_ROOT}
cd ${EPICS_ROOT}
chmod +x assemble_synApps
perl assemble_synApps --update --config=synApps_libi.txt

#build
cd ${SUPPORT}
make


echo "================================DONE=========================="
