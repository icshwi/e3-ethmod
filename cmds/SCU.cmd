# RF Signal Conditioning Unit

require ethmod,2da1bf4f

# Prefix for all records
epicsEnvSet("PREFIX",              "TS2-010RFC:RFS-SCU-110")
epicsEnvSet("AK_IP_PORT_ADDR",     "172.30.4.137:1002")

epicsEnvSet("I2C_TMP100_PORT",     "AK_I2C_TMP100")
epicsEnvSet("I2C_DS28CM00_PORT",   "AK_I2C_DS28CM00")
epicsEnvSet("I2C_PCF85063TP_PORT", "AK_I2C_PCF85063TP")
epicsEnvSet("I2C_M24M02_PORT",     "AK_I2C_M24M02")
epicsEnvSet("I2C_IP_PORT",         "AK_I2C_COMM")
epicsEnvSet("I2C_TCA9555_PORT_1",  "AK_I2C_TCA9555_1")
epicsEnvSet("I2C_TCA9555_PORT_2",  "AK_I2C_TCA9555_2")
epicsEnvSet("I2C_TCA9555_PORT_3",  "AK_I2C_TCA9555_3")
epicsEnvSet("I2C_LTC2991_PORT_1",  "AK_I2C_LTC2991_1")
epicsEnvSet("I2C_LTC2991_PORT_2",  "AK_I2C_LTC2991_2")
epicsEnvSet("I2C_LTC2991_PORT_3",  "AK_I2C_LTC2991_3")

epicsEnvSet("I2C_TMP100_ADDR",     "0x49")
epicsEnvSet("I2C_LTC2991_ADDR",    "0x48")
epicsEnvSet("I2C_M24M02_ADDR",     "0x50")
epicsEnvSet("I2C_TCA9555_ADDR_1",  "0x21")
epicsEnvSet("I2C_TCA9555_ADDR_2",  "0x22")
epicsEnvSet("I2C_TCA9555_ADDR_3",  "0x23")
epicsEnvSet("I2C_LTC2991_ADDR_1",  "0x48")
epicsEnvSet("I2C_LTC2991_ADDR_2",  "0x49")
epicsEnvSet("I2C_LTC2991_ADDR_3",  "0x50")

epicsEnvSet("R_TMP100",            ":Temp-")
epicsEnvSet("R_M24M02",            ":Eeprom-")
epicsEnvSet("R_TCA9555_1",         ":IOExp1-")
epicsEnvSet("R_TCA9555_2",         ":IOExp2-")
epicsEnvSet("R_TCA9555_3",         ":IOExp3-")
epicsEnvSet("R_LTC2991_1",         ":VMon1-")
epicsEnvSet("R_LTC2991_2",         ":VMon2-")
epicsEnvSet("R_LTC2991_3",         ":VMon3-")


# Supported IP port types (see AKBase.h)
#AK_IP_PORT_INVALID       0
#AK_IP_PORT_RS232         1
#AK_IP_PORT_RS485         2
#AK_IP_PORT_LCD           3
#AK_IP_PORT_I2C           4
#AK_IP_PORT_SPI           5
#AK_IP_PORT_TTLIO         6
#AK_IP_PORT_SDCARD        7
#AK_IP_PORT_DFCARD        8

###
# I2C
###
# Create the asyn port to talk to the AK-NORD server on command port 1002.
drvAsynIPPortConfigure($(I2C_IP_PORT),$(AK_IP_PORT_ADDR))
#asynSetTraceIOMask($(I2C_IP_PORT),0,255)
#asynSetTraceMask($(I2C_IP_PORT),0,255)
# Set the terminators
#asynOctetSetOutputEos($(I2C_IP_PORT), 0, "\003")
#asynOctetSetInputEos($(I2C_IP_PORT), 0,  "\003")

#################################################
############ Temperature readout
############ TMP100
#################################################
# AKI2CTMP100Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CTMP100Configure($(I2C_TMP100_PORT), $(I2C_IP_PORT), 1, $(I2C_TMP100_ADDR), 1, 0, 0)
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=$(R_TMP100),PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_TMP100_PORT),0,255)
#asynSetTraceMask($(I2C_TMP100_PORT),0,255)

#################################################
############ EEPROM
############ M24M02
#################################################
# AKI2CM24M02Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CM24M02Configure($(I2C_M24M02_PORT), $(I2C_IP_PORT), 1, $(I2C_M24M02_ADDR), 1, 0, 0)
dbLoadRecords("AKI2C_M24M02.db",       "P=$(PREFIX),R=$(R_M24M02),PORT=$(I2C_M24M02_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1,NELM=16000")
#asynSetTraceIOMask($(I2C_M24M02_PORT),0,255)
#asynSetTraceMask($(I2C_M24M02_PORT),0,255)

#################################################
############ Port Extender
############ TCA9555
#################################################
# AKI2CTCA9555Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CTCA9555Configure($(I2C_TCA9555_PORT_1), $(I2C_IP_PORT), 1, $(I2C_TCA9555_ADDR_1), 1, 0, 0)
dbLoadRecords("AKI2C_TCA9555.db",        "P=$(PREFIX),R=$(R_TCA9555_1),PORT=$(I2C_TCA9555_PORT_1),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_TCA9555_PORT_1),0,255)
#asynSetTraceMask($(I2C_TCA9555_PORT_1),0,255)

# AKI2CTCA9555Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CTCA9555Configure($(I2C_TCA9555_PORT_2), $(I2C_IP_PORT), 1, $(I2C_TCA9555_ADDR_2), 1, 0, 0)
dbLoadRecords("AKI2C_TCA9555.db",        "P=$(PREFIX),R=$(R_TCA9555_2),PORT=$(I2C_TCA9555_PORT_2),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_TCA9555_PORT_2),0,255)
#asynSetTraceMask($(I2C_TCA9555_PORT_2),0,255)

# AKI2CTCA9555Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CTCA9555Configure($(I2C_TCA9555_PORT_3), $(I2C_IP_PORT), 1, $(I2C_TCA9555_ADDR_3), 1, 0, 0)
dbLoadRecords("AKI2C_TCA9555.db",        "P=$(PREFIX),R=$(R_TCA9555_3),PORT=$(I2C_TCA9555_PORT_3),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_TCA9555_PORT_3),0,255)
#asynSetTraceMask($(I2C_TCA9555_PORT_3),0,255)

#################################################
############ Voltage and Current Monitoring
############ LTC2991
#################################################
# AKI2CLTC2991Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CLTC2991Configure($(I2C_LTC2991_PORT_1), $(I2C_IP_PORT), 1, $(I2C_LTC2991_ADDR_1), 0, 0, 1, 0, 0)
dbLoadRecords("AKI2C_LTC2991.db",        "P=$(PREFIX),R=$(R_LTC2991_1),PORT=$(I2C_LTC2991_PORT_1),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_LTC2991_PORT_1),0,255)
#asynSetTraceMask($(I2C_LTC2991_PORT_1),0,255)

# AKI2CLTC2991Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CLTC2991Configure($(I2C_LTC2991_PORT_2), $(I2C_IP_PORT), 1, $(I2C_LTC2991_ADDR_2), 0, 0, 1, 0, 0)
dbLoadRecords("AKI2C_LTC2991.db",        "P=$(PREFIX),R=$(R_LTC2991_2),PORT=$(I2C_LTC2991_PORT_2),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_LTC2991_PORT_2),0,255)
#asynSetTraceMask($(I2C_LTC2991_PORT_2),0,255)

# AKI2CLTC2991Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CLTC2991Configure($(I2C_LTC2991_PORT_3), $(I2C_IP_PORT), 1, $(I2C_LTC2991_ADDR_3), 0, 0, 1, 0, 0)
dbLoadRecords("AKI2C_LTC2991.db",        "P=$(PREFIX),R=$(R_LTC2991_3),PORT=$(I2C_LTC2991_PORT_3),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_LTC2991_PORT_3),0,255)
#asynSetTraceMask($(I2C_LTC2991_PORT_3),0,255)
#################################################

# Load initialization database
dbLoadRecords("SCU.db",         "P=$(PREFIX), R_LTC2991_1=$(R_LTC2991_1), R_LTC2991_2=$(R_LTC2991_2), R_LTC2991_3=$(R_LTC2991_3), R_TCA9555_1=$(R_TCA9555_1), R_TCA9555_2=$(R_TCA9555_2), R_TCA9555_3=$(R_TCA9555_3), R_TMP100=$(R_TMP100), R_M24M02=$(R_M24M02)")
dbLoadRecords("SCU_alias.db",   "P=$(PREFIX), R_LTC2991_1=$(R_LTC2991_1), R_LTC2991_2=$(R_LTC2991_2), R_LTC2991_3=$(R_LTC2991_3), R_TCA9555_1=$(R_TCA9555_1), R_TCA9555_2=$(R_TCA9555_2), R_TCA9555_3=$(R_TCA9555_3)")

# used dbpf since record(*,"record_name") doesn't work for VAL field
### Set P0-P7 to output
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin0 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin1 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin2 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin3 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin4 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin5 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin6 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin7 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin0 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin1 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin2 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin3 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin4 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin5 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin6 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin7 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin0 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin1 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin2 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin3 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin4 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin5 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin6 0")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin7 0")
### Set P11-P17 to input
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin9  1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin10 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin11 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin12 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin13 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin14 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_1)DirPin15 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin9  1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin10 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin11 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin12 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin13 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin14 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_2)DirPin15 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin9  1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin10 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin11 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin12 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin13 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin14 1")
afterInit("dbpf $(PREFIX)$(R_TCA9555_3)DirPin15 1")

#set_requestfile_path("./")
#set_requestfile_path("$(ETHMOD)/ethmodApp/Db")
#set_savefile_path("./autosave")
#set_pass0_restoreFile("auto_settings.sav")
#set_pass1_restoreFile("auto_settings.sav")
#save_restoreSet_status_prefix("$(PREFIX)")
#dbLoadRecords("$(AUTOSAVE)/asApp/Db/save_restoreStatus.db", "P=$(PREFIX)")

#cd "${TOP}/iocBoot/${IOC}"
iocInit()

# save things every thirty seconds
#create_monitor_set("${TOP}/iocBoot/${IOC}/auto_settings.req", 30,"P=$(PREFIX)")

