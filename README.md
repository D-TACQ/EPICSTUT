# Repeat TUT1 but with real data on live IOC

REFS:
https://en.wikipedia.org/wiki/PID_controller
https://en.wikipedia.org/wiki/PID_controller#/media/File:PID_en.svg


```
git clone https://github.com/D-TACQ/EPICSTUT.git
git checkout -b TUT2 origin/TUT2
```
## Extend live IOC

 - sorry, there is some special stuff here:

### Copy extension to UUT:

 - scp control_tut.tar root@UUT:/mnt/local

 - scp sysconfig/epics.sh root@UUT:/mnt/local/sysconfig/epics.sh

What does this do?

/mnt/local/sysconfig/epics.sh

First, unpack the patch package
```[ ! -e /usr/local/epics/db/control_tut.db ] && \
	tar xvf /mnt/local/control_tut.tar -C /usr/local/epics 
```
Second, when the IOC loads, it will run this script.
```
export IOC_PREINIT=./scripts/load.control_tut
```
The script instantiates NCHAN control records.
end result, like this:
```
acq2106_199> grep control_tut /tmp/st.cmd 
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=01,idx=1")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=02,idx=2")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=03,idx=3")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=04,idx=4")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=05,idx=5")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=06,idx=6")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=07,idx=7")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=08,idx=8")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=09,idx=9")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=10,idx=10")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=11,idx=11")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=12,idx=12")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=13,idx=13")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=14,idx=14")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=15,idx=15")
dbLoadRecords("db/control_tut.db","UUT=acq2106_199,SITE=5,CH=16,idx=16")
```

#### Key Points
 - .db file is configured by MACRO PARAMETERS eg ${UUT}, ${CH}
 - .db file creates a set of records each time it's loaded.
 - BUT records with expanded (literal) parameters => we only get ONE record
 - eg GAIN has parameter ${CH} in the name, we get NCHAN*GAIN records, but
 - CONTROL has literal :01 in the name, we get just the one record.
.. that's for this demo ONLY, more normally, we'd include ${CH} in the name for CONTROL and get NCHAN CONTROL records also..
```
acq2106_199> grep :5:GAIN /tmp/records.dbl
acq2106_199:5:GAIN:01
acq2106_199:5:GAIN:02
acq2106_199:5:GAIN:03
acq2106_199:5:GAIN:04
acq2106_199:5:GAIN:05
acq2106_199:5:GAIN:06
acq2106_199:5:GAIN:07
acq2106_199:5:GAIN:08
acq2106_199:5:GAIN:09
acq2106_199:5:GAIN:10
acq2106_199:5:GAIN:11
acq2106_199:5:GAIN:12
acq2106_199:5:GAIN:13
acq2106_199:5:GAIN:14
acq2106_199:5:GAIN:15
acq2106_199:5:GAIN:16
```
```
acq2106_199> grep :5:CONTROL /tmp/records.dbl
acq2106_199:5:CONTROL:01
```


## GUI Client

1. Create cs-studio workspace
1. Import.. FileSystem .. Navigate to TUT/OPI, select OPI, td2.opi
Into Folder CSS
1. From Navigator, select CSS/control_launcher.opi, open in editor, set macros and save:
 - UUT
 - SITE
1. Press the > run button
![GitHub](images/css-design.png)


