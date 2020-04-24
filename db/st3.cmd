dbLoadDatabase("dbd/acq400ioc.dbd",0,0)
acq400ioc_registerRecordDeviceDriver(pdbbase)
dbLoadDatabase("db/test3.db",0,0)
iocInit()

