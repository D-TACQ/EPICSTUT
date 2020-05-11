echo -1 >/etc/acq400/0/OVERSAMPLING
export EPICS_CA_MAX_ARRAY_BYTES=500000
# uncomment for live spectra, but not recommended for production use
# as it can result in loss of data in some conditions
#export IOC_PREINIT=./scripts/load.SpecReal
[ ! -e /usr/local/epics/db/control_tut.db ] && \
	tar xvf /mnt/local/control_tut.tar -C /usr/local/epics 
export IOC_PREINIT=./scripts/load.control_tut
[ -e /dev/shm/window ] || \
	ln -s /usr/local/CARE/hanning-float.bin /dev/shm/window

export IOC_POSTINIT=/mnt/local/sysconfig/set_dt_test_role
export IOC_POSTINIT=/mnt/local/sysconfig/set_dt_test_role
