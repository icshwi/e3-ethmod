# RF Electron Pickup

require ethmod,2da1bf4f

# Prefix for all records
epicsEnvSet("PREFIX",              "LAB-010CRM:RFS-ED-010")
epicsEnvSet("AK_IP_PORT_ADDR",     "172.30.5.33:1002")

epicsEnvSet("I2C_TMP100_PORT",     "AK_I2C_TMP100")
epicsEnvSet("I2C_DS28CM00_PORT",   "AK_I2C_DS28CM00")
epicsEnvSet("I2C_PCF85063TP_PORT", "AK_I2C_PCF85063TP")
epicsEnvSet("I2C_TCA9555_PORT",    "AK_I2C_TCA9555")
epicsEnvSet("I2C_LTC2991_PORT",    "AK_I2C_LTC2991")
epicsEnvSet("I2C_M24M02_PORT",     "AK_I2C_M24M02")
epicsEnvSet("I2C_AD527X_PORT",     "AK_I2C_AD527X")
epicsEnvSet("I2C_IP_PORT",         "AK_I2C_COMM")

epicsEnvSet("R_TMP100",  ":Temp1-")
epicsEnvSet("R_M24M02",  ":Eeprom1-")
epicsEnvSet("R_TCA9555", ":IOExp1-")
epicsEnvSet("R_LTC2991", ":VMon1-")
epicsEnvSet("R_AD527X",  ":Res1-")

epicsEnvSet("I2C_TMP100_ADDR",  "0x49")
epicsEnvSet("I2C_LTC2991_ADDR", "0x48")
epicsEnvSet("I2C_M24M02_ADDR",  "0x50")
epicsEnvSet("I2C_TCA9555_ADDR", "0x21")
epicsEnvSet("I2C_LTC2991_ADDR", "0x48")
epicsEnvSet("I2C_AD527X_ADDR",  "0x2E")


#################################################
############ I2C
#################################################
# Create the asyn port to talk to the AK-NORD server on command port 1002.
drvAsynIPPortConfigure($(I2C_IP_PORT),$(AK_IP_PORT_ADDR))
#-asynSetTraceIOMask($(I2C_IP_PORT),0,255)
#-asynSetTraceMask($(I2C_IP_PORT),0,255)
# Set the terminators
#-asynOctetSetOutputEos($(I2C_IP_PORT), 0, "\003")
#-asynOctetSetInputEos($(I2C_IP_PORT), 0,  "\003")

#################################################
############ Temperature readout
############ TMP100
#################################################
# AKI2CTMP100Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CTMP100Configure($(I2C_TMP100_PORT), $(I2C_IP_PORT), 1, $(I2C_TMP100_ADDR), 1, 0, 0)
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=$(R_TMP100),PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#-asynSetTraceIOMask($(I2C_TMP100_PORT),0,255)
#-asynSetTraceMask($(I2C_TMP100_PORT),0,255)

#################################################
############ EEPROM
############ M24M02
#################################################
# AKI2CM24M02Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CM24M02Configure($(I2C_M24M02_PORT), $(I2C_IP_PORT), 1, $(I2C_M24M02_ADDR), 1, 0, 0)
dbLoadRecords("AKI2C_M24M02.db",       "P=$(PREFIX),R=$(R_M24M02),PORT=$(I2C_M24M02_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1,NELM=16000")
#-asynSetTraceIOMask($(I2C_M24M02_PORT),0,255)
#-asynSetTraceMask($(I2C_M24M02_PORT),0,255)

#################################################
############ Port Extender
############ TCA9555
#################################################
# AKI2CTCA9555Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CTCA9555Configure($(I2C_TCA9555_PORT), $(I2C_IP_PORT), 1, $(I2C_TCA9555_ADDR), 1, 0, 0)
dbLoadRecords("AKI2C_TCA9555.db",        "P=$(PREFIX),R=$(R_TCA9555),PORT=$(I2C_TCA9555_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#-asynSetTraceIOMask($(I2C_TCA9555_PORT),0,255)
#-asynSetTraceMask($(I2C_TCA9555_PORT),0,255)

afterInit("dbpf $(PREFIX)$(R_TCA9555)DirPin0 1")    # Input : Test Monitoring
afterInit("dbpf $(PREFIX)$(R_TCA9555)DirPin1 1")    # Input : Interlock OFF
afterInit("dbpf $(PREFIX)$(R_TCA9555)DirPin2 1")    # Input : Interlock ON
afterInit("dbpf $(PREFIX)$(R_TCA9555)DirPin7 0")    # Output: test LED

#################################################
############ Voltage and Current Monitoring
############ LTC2991
#################################################
# AKI2CLTC2991Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CLTC2991Configure($(I2C_LTC2991_PORT), $(I2C_IP_PORT), 1, $(I2C_LTC2991_ADDR), 0, 0, 1, 0, 0)
dbLoadRecords("AKI2C_LTC2991.db",        "P=$(PREFIX),R=$(R_LTC2991),PORT=$(I2C_LTC2991_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#-asynSetTraceIOMask($(I2C_LTC2991_PORT),0,255)
#-asynSetTraceMask($(I2C_LTC2991_PORT),0,255)

#################################################
############ Digital Rheostat 
############ AD5272BR
#################################################
# AKI2CAD527xConfigure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CAD527xConfigure($(I2C_AD527X_PORT), $(I2C_IP_PORT), 1, $(I2C_AD527X_ADDR), 0, 0, 1, 0, 0)
dbLoadRecords("AKI2C_AD527x.db",        "P=$(PREFIX),R=$(R_AD527X),PORT=$(I2C_AD527X_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#-asynSetTraceIOMask($(I2C_AD527X_PORT),0,255)
#-asynSetTraceMask($(I2C_AD527X_PORT),0,255)

#################################################

# Load initialization database
dbLoadRecords("e_pickup.db","P=$(PREFIX), R_LTC2991=$(R_LTC2991), R_TMP100=$(R_TMP100), R_M24M02=$(R_M24M02), R_TCA9555=$(R_TCA9555), R_AD527X=$(R_AD527X)")

#- set_requestfile_path("./")
#- set_requestfile_path("$(ETHMOD)/ethmodApp/Db")
#- set_savefile_path("./autosave")
#- set_pass0_restoreFile("auto_settings.sav")
#- set_pass1_restoreFile("auto_settings.sav")
#- save_restoreSet_status_prefix("$(PREFIX)")
#- dbLoadRecords("$(AUTOSAVE)/asApp/Db/save_restoreStatus.db", "P=$(PREFIX)")

#- cd "${TOP}/iocBoot/${IOC}"
iocInit()

#-  save things every thirty seconds
#- create_monitor_set("${TOP}/iocBoot/${IOC}/auto_settings.req", 30,"P=$(PREFIX)")

