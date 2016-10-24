BEGIN;
--BEGIN;
create table dbUpdateRegisterTbl (
    compName text NOT NULL,
    stopIfError integer NOT NULL,
    waitForMe   integer NOT NULL,
    tableName text NOT NULL,
    rowIndex  integer,
    onUpdate integer NOT NULL,
    onAdd   integer NOT NULL,
    onDelete integer NOT NULL,
    isPrograms integer NOT NULL
);

create table sqliteLock
(
lock integer
);

--create table dbUpdateRegisterProgram
--(
  --  progName text NOT NULL,
  --  stopIfError integer NOT NULL,
  --  waitForMe   integer NOT NULL,
  --  tableName text NOT NULL,
  --  rowIndex  integer,
  --  onUpdate integer NOT NULL,
  --  onAdd   integer NOT NULL,
  --  onDelete integer NOT NULL
--);

--insert into dbUpdateRegisterTbl values ("p2p_limit.sh",1,1,"voipwatchdog", 0, 1,0,0,1);
--insert into dbUpdateRegisterTbl values ("UMI_COMP_VOIP_WDOG",1,1,"voipwatchdog", 0, 1,1,1,0);

CREATE TABLE system
(
    name    text NOT NULL,
    domain  text,
    description text,
    firmwareVer text,
    hardwareVer text,
    voipVer     text,
    tr069Ver    text,
    jnrpVer     text,
    vendor      text,
    serNum      text,
    sysContact  text,
    sysLoc      text,
    PRIMARY KEY (name)
);

CREATE TABLE users
(
    username  text NOT NULL,
    password  text,
    groupname  text NOT NULL,
    loginTimeout  integer NOT NULL,
    descr text,                     -- brief description about the user
    --PRIMARY KEY (username,groupname),
    FOREIGN KEY (groupname) REFERENCES groups(name)
);

CREATE TABLE groups
(
    name text NOT NULL,               -- group name
    descr text,                     -- brief description about the group
    accessLevel integer NOT NULL,    -- 0 - for readonly, 1 - for conditional read/write, 2 - for fully read/write
    PRIMARY KEY (name)
);
create table voipwatchdog (
    Id  integer NOT NULL,
    context text,
    PRIMARY KEY (Id)
);

--insert into voipwatchdog values (1,"test1");
--insert into voipwatchdog values (2,"test2");



CREATE TABLE Lan
    (
    LogicalIfName   text    NOT NULL,
    Mtu             integer NOT NULL,
    IpAddress       text    NOT NULL,
    SubnetMask      text    NOT NULL,
    IfStatus        boolean NOT NULL,
    MacAddress      text    NOT NULL,
    PRIMARY KEY (LogicalIfName),
    FOREIGN KEY (LogicalIfName) REFERENCES networkInterface(LogicalIfName)
    );
--insert into Lan values ("LAN1",1500,"192.168.0.1","255.255.255.0",1,"00:00:00:00");

CREATE TABLE networkInterface
    (
    interfaceName   text    NOT NULL,
    LogicalIfName   text    NOT NULL,
    VirtualIfName   text    NOT NULL,
    ConnectionType  text    NOT NULL,
    ConnectionType6 text    NOT NULL,
    ifType          text,
    MTU             integer,
    ipaddr          text,
    subnetmask      text,
    gateway         text,
    dns1            text,
    dns2            text,
    DHCP            integer,
    IfStatus        integer NOT NULL,
    refreshInterval integer NOT NULL,
    autoRefreshFlag integer NOT NULL,
    capabilities    integer NOT NULL,
    PRIMARY KEY (interfaceName,LogicalIfName)
)
;
--insert into networkInterface values ("br0", "LAN1", "bdg1", "ifStatic", "", "bridge",
--                   1500, "192.168.0.1", "255.255.255.0",
--                   "0.0.0.0", "0.0.0.0", "0.0.0.0", 0, 1, 5,
--                   0,1);

--insert into networkInterface values ("eth1", "WAN", "eth1", "dhcpc",
--                   "","ethernet", 1500, "0.0.0.0", "0.0.0.0",
--                   "0.0.0.0", "0.0.0.0", "0.0.0.0",
--                   0, 0, 5, 0,1);

--insert into networkInterface values ("sit0", "sit0-WAN", "sit0", "",
--                   "","tunnel", 1500, "0.0.0.0", "0.0.0.0",
--                   "0.0.0.0", "0.0.0.0", "0.0.0.0",
--                   0, 0, 5, 0,2);

--insert into networkInterface values ("usb0", "LTE-WAN1", "usb0", "",
--                   "","lte1", 1500, "0.0.0.0", "0.0.0.0",
--                   "0.0.0.0", "0.0.0.0", "0.0.0.0",
--                   0, 0, 5, 0,1);
--insert into networkInterface values ("usb1", "LTE-WAN2", "usb1", "",
--                   "","lte2", 1500, "0.0.0.0", "0.0.0.0",
--                   "0.0.0.0", "0.0.0.0", "0.0.0.0",
--                   0, 0, 5, 0,1);
-- real time update tables
create table ipAddressTable
(
    LogicalIfName text NOT NULL,        -- hardware interface name
    addressFamily integer,              -- Address family
    isStatic boolean,                   -- static assigned or dynamic
    ipAddress text,                     -- IP address
    ipDstAddres text,                   -- End point for P-to-P
    ipv6PrefixLen integer,              -- IPv6 prefix length
    subnetMask text,                    -- subnet mask
    FOREIGN KEY (LogicalIfName) REFERENCES networkInterface(LogicalIfName)
);

create table resolverConfig
(
    LogicalIfName    text    NOT NULL,  -- WAN1, WAN2, LAN
    addressFamily    integer NOT NULL,  -- Address family
    nameserver1      text            ,  -- DNS nameserver 1
    nameserver2      text            ,  -- DNS nameserver 2
    PRIMARY KEY (LogicalIfName, addressFamily),
    FOREIGN KEY (LogicalIfName) REFERENCES networkInterface(LogicalIfName)
);

create table  defaultRouters
(
  LogicalIfName    text    NOT NULL,    -- WAN1, WAN2, LAN
  addressFamily    integer NOT NULL,    -- Address family
  nextHopGateway   text            ,    -- Next hop gateway
  interfaceName    text            ,    -- for interface route
  PRIMARY KEY (LogicalIfName, addressFamily),
  FOREIGN KEY (LogicalIfName) REFERENCES networkInterface(LogicalIfName)
);

create table  StaticRoute
(
    Enable          boolean NOT NULL,
    Name            text NOT NULL,
    DestineNetwork  text NOT NULL,
    DestineNetmask  text NOT NULL,
    Local  text NOT NULL,
    LocalGateway  text
);

CREATE TABLE LANStatus
(
    portNumber   text NOT NULL,
    ipAddress       text,
    macAddress      text,
    speed          text,
    linkstatus    integer NOT NULL,
    PRIMARY KEY (portNumber)
);
-- end of real time update tables

CREATE TABLE DhcpServerBasic
(
    Id  integer NOT NULL,
    Enable          boolean NOT NULL,
    StartIpAddress  text NOT NULL,
    EndIpAddress    text NOT NULL,
    Range           integer NOT NULL,
    LeaseTime       integer NOT NULL,   -- number of seconds
    IpReserveEnable   boolean NOT NULL,
	IpPhoneVendorID	text,
    PRIMARY KEY (Id)
);

--insert into DhcpServerBasic values (1,1,"192.168.0.2","192.168.0.254",253,24);

CREATE TABLE DhcpServerPools
(
    Enable                  boolean NOT NULL,
    PoolID                  integer NOT NULL,
    PoolOrder               integer,
    LogicalIfName           text    NOT NULL,

    VendorClassID           text,
    VendorClassIDExclude    boolean,
    VendorClassIDMode       text,
    VendorClassMatchOff     integer,
    VendorClassMatchLen     integer,

    ClientID                text,
    ClientIDExclude         boolean,

    UserClassID             text,
    UserClassIDExclude      boolean,

    Chaddr                  text,
    ChaddrMask              text,
    ChaddrExclude           boolean,

    MinAddress              text NOT NULL,
    MaxAddress              text NOT NULL,

    DNSServers              integer,
    DNSServer1              text,
    DNSServer2              text,
    DNSServer3              text,

    DomainName              text,
    IPRouters               text,
    DHCPLeaseTime           integer,

    DefaultPool             boolen NOT NULL,    -- default pool for this interface

    PRIMARY KEY   (PoolID),
    FOREIGN KEY   (DomainName) REFERENCES system (domain)
    FOREIGN KEY   (LogicalIfName) REFERENCES networkInterface (LogicalIfName)
);

CREATE TABLE DhcpOption
(
    PoolID  integer NOT NULL,
    Enable      boolean NOT NULL,
    OptionScope integer NOT NULL,
    OptionCode  integer NOT NULL,
    value1      text,
    value2      text,
    value3      text,
    FOREIGN KEY (PoolID) REFERENCES DhcpServerPools (PoolID)
);

-- dhcpd real time table
CREATE TABLE DhcpLeasedClients
(
   LogicalIfName text  NOT NULL,
   hostName  text,
   IPAddr        text,
   MacAddr       text NOT NULL,
   Starts        text,
   Ends          text,
   clientIf  text,
   Timeout  text,
   State         text
   --State         text,
   --PRIMARY KEY   (IPAddr,hostName)
);

CREATE TABLE DhcpfixedIpAddress
(
    PoolID    integer NOT NULL,
    Enable  boolean NOT NULL,
    IpAddr        text,
    MacAddr       text NOT NULL    
    --PRIMARY KEY   (IpAddr,MacAddr),
    --FOREIGN KEY (PoolID) REFERENCES DhcpServerPools (PoolID)
);

-- for bridge mode
-- for bridge mode
CREATE TABLE FirewallNatConfig
(
    Id  integer NOT NULL,
    Enable  boolean NOT NULL,
    PortForwardingEnable    boolean NOT NULL,
    PRIMARY KEY (Id)
);
--insert into FirewallNatConfig values (1,1,0);

CREATE TABLE FirewallConfig
(
    Id	integer NOT NULL,
    Enable	boolean NOT NULL, -- 1:Enable, 0:Disable (default:1)
    PacketFilterEnable	boolean NOT NULL, -- 1:Enable, 0:Disable (default:0)
    MacFilterEnable	boolean NOT NULL, -- 1:Enable, 0:Disable (default:0)
    UrlFilterEnable	boolean NOT NULL, -- 1:Enable, 0:Disable (default:0)
    ICMPBLOCK	boolean NOT NULL, -- ICMP Ping Block, 1:Block, 0:Unblock (default:0)
    TCPSynEnable	boolean NOT NULL, -- 1:Enable, 0:Disable (default:1)
    TCPFinEnable	boolean NOT NULL, -- 1:Enable, 0:Disable (default:1)
    TCPSynFlood	integer NOT NULL, -- SYN Flood max value (default:128)
    TCPFinFlood	integer NOT NULL, -- FIN Flood max value (default:128)
    ICMPFlood	integer NOT NULL, -- ICMP Flood max value (default:128)
    ICMPPingFlood	integer NOT NULL, -- ICMP Ping Flood max value (default:128)
    PRIMARY KEY	(Id)
);
--insert into FirewallConfig values (1,1,0,0,0);

-- Remote Manager Config
create table RmtMgrConfig
(
	Id	integer NOT NULL,
	Enable_TR69	boolean NOT NULL,	-- 1:Enable, 0:Disable (default : 1)
	Enable_VOIP	boolean NOT NULL,	-- 1:Enable, 0:Disable (default : 1)
	Enable_HTTP	boolean NOT NULL,	-- 1:Enable, 0:Disable (default : 0)
	Enable_TELNET	boolean NOT NULL,	-- 1:Enable, 0:Disable (default : 0)
	Enable_SSH	boolean NOT NULL,	-- 1:Enable, 0:Disable (default : 0)
	PRIMARY	KEY	(Id)
);

--CREATE TABLE FirewallRules
--(

--);

CREATE TABLE FirewallDmz
(
    Id  integer NOT NULL,
    Enable      boolean NOT NULL,
    DmzIpAddress    text NOT NULL,
    PRIMARY KEY (Id)
);


CREATE TABLE PacketFilter
(
    Enable      boolean NOT NULL,
    IpAddr      text NOT NULL,
    Protocol    text NOT NULL,
    portRange   text NOT NULL,
    Comment     text
);

CREATE TABLE MacFilter
(
    Enable      boolean NOT NULL,
    MacAddr     text NOT NULL,
    Comment     text
);

CREATE TABLE UrlFilter
(
    Enable      boolean NOT NULL,
    Url         text NOT NULL,
    Comment     text
);

CREATE TABLE DoS
(
    Id          integer NOT NULL,
    Enable      boolean NOT NULL,
    TCPSynEnable    boolean NOT NULL,
    TCPFinEnable    boolean NOT NULL,
    UDPEnable   boolean NOT NULL,
    ICMPEnable  boolean NOT NULL,
    TCPPERIPEnable  boolean NOT NULL,
    TCPFinPERIPEnable   boolean NOT NULL,
    UDPPERIPEnable  boolean NOT NULL,
    ICMPPERIPEnable boolean NOT NULL,
    IPSpoofEnable   boolean NOT NULL,
    TCPSynFlood         integer NOT NULL,
    TCPFinFlood         integer NOT NULL,
    UDPFlood            integer NOT NULL,
    ICMPFlood           integer NOT NULL,
    TCPSynFlood_perip   integer NOT NULL,
    TCPFinFlood_perip   integer NOT NULL,
    UDPFlood_perip      integer NOT NULL,
    ICMPFlood_perip     integer NOT NULL,
    Comment     text,
    PRIMARY KEY (Id)
);

CREATE TABLE SPI
(
    Id  integer NOT NULL,
    Enable      boolean NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE PortForwarding
(
    Enable      	boolean NOT NULL,
    Ip          	text NOT NULL,
    Protocol    	text NOT NULL,
    portRange   	text NOT NULL,
    Comment     	text,
    ServiceName 	text NOT NULL,
	DNATPortEnable 	integer NOT NULL,
 	DNATPort 		integer NOT NULL
);

CREATE TABLE tr69Config
(
    Enable integer DEFAULT 1,
    URL         text,
    Username    text,
    Password    text,
    STUNEnable  text,
    STUNServerAddress   text,
    STUNUsername    text,
    STUNPassword    text,
    SerialNumber    text,
    ConnectionRequestUsername   text,
    ConnectionRequestPassword   text,
    ConnectionRequestPort   text,
    CACertPath      text,
    ClientCertPath  text,
    Passphrase      text,
    ProvisioningCode text,
	InterfaceName	text,
    PeriodicInformEnable text DEFAULT ('1'),
    PeriodicInformInterval INTEGER DEFAULT (3600),
    FirstUseDate  text DEFAULT ('Null'),
    UpgradeOnlyLTE  text DEFAULT ('1'),
    PRIMARY KEY (URL)
);
--insert into tr69Config values('http://cosmos.bredband.com:8080/ACS-server/ACS','','','0','132.177.123.13','','','','','','/flash/ca.pem','/flash/agent.pem','','og4610-TR069');

-- MacTable - table for MAC refresh
create table MacTable
    (
    interfaceName            text     NOT NULL, -- interface name
    MacAddress               text     NOT NULL,
    PRIMARY KEY (interfaceName),                -- primary key
    FOREIGN KEY (interfaceName) REFERENCES networkInterface (interfaceName)
    );

--insert into MacTable values('br0',"00:00:00:00");
--insert into MacTable values('eth1',"00:00:00:00");
--insert into MacTable values('wlan0',"00:00:00:00");
--insert into MacTable values('wlan0.0',"00:00:00:00");
--insert into MacTable values('wlan0.1',"00:00:00:00");
--insert into MacTable values('wlan0.2',"00:00:00:00");


CREATE TABLE ntpConfig
(
   timezone  integer NOT NULL,
   enabled  integer NOT NULL,
   autoDaylight  integer NOT NULL,
   useDefServers  integer NOT NULL,
   server1  text NOT NULL,
   server2  text NOT NULL,
   server3  text NOT NULL,
   reSyncNtpVal integer NOT NULL,
   networkMode integer  NOT NULL
)
;

CREATE TABLE RemoteLog
(
    serverName  text NOT NULL,      -- servername or ip
    serverPort  integer DEFAULT 514,
    facilityId  integer,            --Ex: kernel 0
    severity    integer,            --Ex: emergency 1
    Enable      integer,            -- 1- enable , 0- disable
    serverId    integer             -- i th syslog server (0 to 7)
)
;


CREATE TABLE dlnaConfig
(
   enable integer DEFAULT 0        -- 1: enable, 0: disable
)
;


-- saveTables for export ascii
create table saveTables (
    tableName text NOT NULL,
    PRIMARY KEY(tableName)
);
--insert into saveTables values("voipwatchdog");
--insert into saveTables values("Lan");
--insert into saveTables values("DhcpServerBasic");
--insert into saveTables values("FirewallDmz");
--insert into saveTables values("FirewallNatConfig");
--insert into saveTables values("FirewallConfig");
--insert into saveTables values("tr69Config");
--insert into saveTables values("system");
--insert into saveTables values("users");
--insert into saveTables values("groups");
--COMMIT;

create table UPNP
(
	Id	integer NOT NULL,
	Enable	boolean NOT NULL,	-- 1:Enable, 0:Disable
	PRIMARY	KEY	(Id)
);

-- UPNP Port Mapping Table
CREATE TABLE UPNPortMap
(
	DestIP	text,
	Protocol	text,
	IntPort	integer,
	ExtPort	integer	
);

CREATE TABLE RoutingConfig
(
    Id	integer NOT NULL,
    DynamicRoutingEnable      boolean NOT NULL,
    StaticRoutingEnable      boolean NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE StaticRouting
(
    Enable      boolean NOT NULL,
    DestIP      text NOT NULL,
    DestMask    text NOT NULL,
    device              text NOT NULL,
    gateway          text NOT NULL
);

CREATE TABLE Services
(
  ServiceName text NOT NULL, -- name of the service
  Protocol integer NOT NULL, -- TCP/UDP/ICMP
  DestinationPortStart integer NULL, -- first TCP/UDP port or ICMP type
  DestinationPortEnd integer NULL, -- last TCP/UDP port
  TypeOfService integer NULL, -- type of service
  IsDefault boolean NOT NULL
  --PRIMARY KEY (ServiceName)
);

CREATE TABLE QoS
(
	Enable	boolean NOT NULL,	-- default : 0 (disable)
	DL_Total	integer NOT NULL,	-- default : 10
	DL_Highest	integer NOT NULL,	-- default : 10
	DL_High	integer NOT NULL,	-- default : 10
	DL_Nornmal	integer NOT NULL,	-- default : 10
	DL_Low	integer NOT NULL,	-- default : 10
	UL_Total	integer NOT NULL,	-- default : 10
	UL_Highest	integer NOT NULL,	-- default : 10
	UL_High	integer NOT NULL,	-- default : 10
	UL_Nornmal	integer NOT NULL,	-- default : 10
	UL_Low	integer NOT NULL,	-- default : 10
	Default_Priority	integer NOT NULL	-- default : 5 (no limit)
);

CREATE TABLE QosRule
(
	Enable  boolean NOT NULL DEFAULT 0,
	Name    text,	-- service name
	Priority        integer,	-- 1:Urgent, 2:High, 3:Medium, 4:Low, 5:None
	Rule    text,	-- IP, DSCP
	Flow    text,
	Content text	-- content of IP or DSCP
);

CREATE TABLE PeerToPeer
(
        Enable                  integer NOT NULL,
        Sessions                text NOT NULL
);

CREATE TABLE wifiSchedules
(
    scheduleName text,
    scheduleStatus text,
    startHour text,
    startMinute text,
    startMeridian text,
    stopHour text,
    stopMinute text,
    stopMeridian text,
    associatedSSID text
);

-- new added table for wld3 style webui start 
CREATE TABLE SecurityConfig
(
    Mode integer DEFAULT 2        -- 1:max 2:typical 3:no
);

CREATE TABLE hostTbl
(
    IpAddr      text NOT NULL,      -- IP Address
    Cname       text NOT NULL,       -- Canonical Host Name
    PRIMARY KEY (Cname)
);

CREATE TABLE ContentFltr
(
    ContentFltrName     text NOT NULL,
    Policy              integer,
    Color               integer,
    PRIMARY KEY (ContentFltrName)
);

CREATE TABLE Fltr
(
    ContentFltrName     text NOT NULL,
    FltrType            integer,
    FltrString          text,
    FOREIGN KEY (ContentFltrName) REFERENCES ContentFltr (ContentFltrName)
);

CREATE TABLE FirewallRule
(
    ServiceName text NOT NULL,
    HostName text NOT NULL,  
    Status integer NOT NULL
);

CREATE TABLE Schedules
(
    ScheduleName  text NOT NULL,
    AllDay        integer NULL,
    StartTimeHours integer NULL,
    StartTimeMins  integer NULL,
    StartTimeMeridian integer NULL,
    EndTimeHours  integer NULL,
    EndTimeMins   integer NULL,
    EndTimeMeridian integer NULL,
    Days          integer NULL,
    DaysType      integer NULL,
    PRIMARY KEY (ScheduleName)
);
CREATE TABLE UrlFltrConfig
(
    EnableProfiles      integer NOT NULL
);

CREATE TABLE UrlProfile
(
    ProfileName     text NOT NULL,
    ProfileDecr     text,
    UserType        text,
    UserName        text,
    EnableContentFltr integer,
    ContentFltrName   text,
    EnableSchedules   integer,
    ScheduleName      text,
    SessionTimeout    integer,
    InactivityTimeout integer,
    PRIMARY KEY(ProfileName),
    FOREIGN KEY (ContentFltrName) REFERENCES ContentFltr (ContentFltrName),
    FOREIGN KEY (ScheduleName) REFERENCES Schedules (ScheduleName)
);

CREATE TABLE SambaAccount
(
    Username    text NOT NULL,
    Password    text
);

CREATE TABLE SambaSetting
(
    DisplayUI	integer,
    Ena         integer,
    Name        text,
    Descr       text,
    Workgroup   text,
    ActiveUser	text
);

CREATE TABLE SambaShare
(
    Name        text,
    Path        text,
    RwLvl       integer,
    Users       text
);

CREATE TABLE VpnConfig
(
    pt_pptp     integer NOT NULL,
    pt_l2tp     integer NOT NULL,
    pt_ipsec    integer NOT NULL,
    vpn_mode    text    NOT NULL,
    vpn_ipsec_mode      text,
    nat_traversal       text,
    keep_alive  text,
    vpns_pptp_remote_ip_range   text,
    vpns_l2tp_remote_ip_range   text,
    vpns_l2tp_mode              text NOT NULL,
    vpnc_pptp_username          text NOT NULL,
    vpnc_pptp_password          text,
    vpnc_pptp_server            text,
    vpnc_l2tp_username          text NOT NULL,
    vpnc_l2tp_password          text,
    vpnc_l2tp_server            text,
    vpnc_l2tp_mode              text NOT NULL
);

CREATE TABLE VpnPPTPUserAccount
(
    username    text,
    password    text
);

CREATE TABLE VpnL2TPUserAccount
(
    username    text,
    password    text
);

CREATE TABLE VpnIPSec
(
        name                            text,
        remote_security_gateway         text,
        remote_network_ipaddr           text,
        remote_network_netmask          text,
        preshared_key                   text,
        mode                            text,
        phase1_encryption_algorithm     text,
        phase1_integrity_algorithm      text,
        phase1_dh_group                 text,
        sa_lifetime                     text,
        phase2_encryption_algorithm     text,
        phase2_integrity_algorithm      text,
        phase2_dh_group                 text,
        ipsec_lifetime                  text
);

CREATE TABLE PortForward
(
 ServiceName 	text NOT NULL,
 DNATAddress 	text NOT NULL,
 DNATPortEnable 	integer NOT NULL,
 DNATPort 		integer NOT NULL
);

CREATE TABLE ipRanges
(
	startIP text,
	endIP   text
);

CREATE TABLE accessMgmt
(
    accessMgmtEnable integer NOT NULL,
    serviceType integer NOT NULL,
    accessMgmtIP1 text,
    accessMgmtIP2 text ,
    accessType integer NOT NULL,
    port integer NOT NULL
);

CREATE TABLE ddns
(
 interfaceName text NOT NULL, -- usb0
 ddnsService text NOT NULL,
 hostname text,
 username text,
 password text,
 timePeriod integer,
 wildflag integer
);

CREATE TABLE ResetToDefault
(
 resetToDefault integer NOT NULL
);

CREATE TABLE sysLogInfo
(
	enableLog integer NOT NULL,
	logCategory   integer
);

-- new added table end

CREATE TABLE ApFwUpgrade
(
	EngUpgrade integer NOT NULL,
	P01001_KEY text NOT NULL,
	P01002_KEY text NOT NULL,
	P01003_KEY text NOT NULL,
	P02001_KEY text NOT NULL,
	P02002_KEY text NOT NULL,
	P02003_KEY text NOT NULL
);
CREATE TABLE crontab
(
    unit        integer NOT NULL,
    interval    integer,
    minute      integer,
    hour        integer,
    dayOfMonth  integer,
    month       integer,
    dayOfWeek   integer,
    command     text
);
insert into dbUpdateRegisterTbl values ("UMI_COMP_CRON",1,1,"crontab", 0,1,1,1,0);
insert into saveTables values("crontab");
-- Tables used for LTE component.
--
-- This table stores the configuration related to a LTE WAN connection.
--
--BEGIN;
CREATE TABLE ltePinStatus
    (
    pinId                  Integer, -- 1-PIN1
                                    -- 0-PIN2
    pinStatus              Integer, -- 0 : PIN not initialized
                                        -- 1 : PIN enabled, not verified
                                        -- 2 : PIN enabled, verified
                                        -- 3 : PIN disabled
                                        -- 4 : PIN blocked
                                        -- 5 : PIN permanently blocked
    pinVerifyRetryLeft     Integer, -- pin 1 verify retry count
    pinUnblockRetryLeft    Integer, -- pin 1 unblock retry count
    pinValue                Text     -- pin value given by user
    --PRIMARY KEY (pinId)
    );

CREATE TABLE lteNwProfile
    (
    id                     Integer NOT NULL,
    name                   Text,
    PDPType                Integer,
    APNName                Text,
    Username               Text,
    Password               Text,
    Authentication         Integer,
    interfaceName           Text,  -- usb0 or usb1

    PRIMARY KEY (id)        -- primary key
    );

CREATE TABLE lteHwInfo
    (
    id                     Integer NOT NULL,
    ESN                    Text,
    IMEI                   Text,
    MEID                   Text,
    ModelID                Text,
    RevID                  Text,
    HardwareRev            Text,
    ICCID                  Text,
    IMSI                   Text,
    PRIMARY KEY (id)        -- primary key
    );
--insert into lteHwInfo ('id','IMEI') values (1,"");

CREATE TABLE lteOperatorList
    (
        providerName           Text,  -- provider name
        mcc                    Integer,        -- valid value range from 0 to 999
        mnc                    Integer,              -- valid value range from 0 to 999
        rat                    Integer,
        PRIMARY KEY(providerName)
    );


CREATE TABLE lteRadio                                                -- This table is used to log user's LTE settings
    (
    id                      Integer NOT NULL,
    lte_mode               Text,            -- lte mode preference "auto", "3G", "4G"
    lte_band               Text,            -- lte band preference "auto", "2600", "900", "800"
    apn_status             Integer,          -- 1: use 1 apn, 2: use 2 apn
    PRIMARY KEY(id)
    );

CREATE TABLE lteNwStatus
    (
    qid                     Integer NOT NULL,
    rx_packets_ok          Integer,
    rx_errors              Integer,
    rx_overflows           Integer,
    rx_bytes_ok            Integer,
    tx_packets_ok          Integer,
    tx_errors              Integer,
    tx_overflows           Integer,
    tx_bytes_ok            Integer,
    registrationState      Text,
    radioInterference      Text,
    rssi                   Text,
	rsrq                   Text,
	rsrp                   Text,
	snr                    Text,
    signalStrength         Integer,
    MCC                    Integer,
    MNC                    Integer,
    networkName            Text,
    CellID                 Integer,
    lteRegMethod           Text,                    -- {"auto", "manual"}
	Roaming				   Text,
    PRIMARY KEY (qid)        -- primary key
    );

CREATE TABLE lteIPStatus
    (
    qid                     Integer,
    status                 Text,
    ip                     Text,
    gateway                Text,
    netmask                Text,
    primary_dns                Text,
    secondary_dns              Text,
    PRIMARY KEY (qid)        -- primary key
    );
--COMMIT;
CREATE TABLE DbgSetting (
    "CmDbg_DbgLvl" INTEGER DEFAULT (0),
    "CmDbg_DbgType" INTEGER DEFAULT (0),
    "MmDbg_DbgLvl" INTEGER DEFAULT (0),
    "MmDbg_DbgType" INTEGER DEFAULT (0),
    "AgentsDbg_DbgLvl" INTEGER DEFAULT (0),
    "AgentsDbg_DbgType" INTEGER DEFAULT (0),
    "RtpDbg_DbgLvl" INTEGER DEFAULT (0),
    "RtpDbg_DbgType" INTEGER DEFAULT (0),
    "VmapiDbg_DbgLvl" INTEGER DEFAULT (0),
    "VmapiDbg_DbgType" INTEGER DEFAULT (0),
    "SipDbg_DbgLvl" INTEGER DEFAULT (0),
    "SipDbg_DbgType" INTEGER DEFAULT (0),
    "FaxDbg_DbgLvl" INTEGER DEFAULT (0),
    "FaxDbg_DbgType" INTEGER DEFAULT (0),
    "COMMENT" TEXT
);
CREATE TABLE VoiceProfile (
    "ProfileId"               INTEGER DEFAULT (0),
    "ProfileName"             TEXT DEFAULT ('0'),
    "AssocCountry"            INTEGER DEFAULT (0),
    "State"                   INTEGER DEFAULT (0),
    "Reset"                    INTEGER DEFAULT (0),
    "NoOfLines"               INTEGER DEFAULT (0),
    "Lines"                  INTEGER DEFAULT (0),
    "AssoLineIds"            INTEGER DEFAULT (0),
    "DtmfPayloadType"         INTEGER DEFAULT (0),
    "DtmfMethod"              INTEGER DEFAULT (0),
    "G711DtmfMethod"          INTEGER DEFAULT (0),
    "EnableDigitMap"           INTEGER DEFAULT (0),
    "DigitMap"                TEXT DEFAULT ('0'),
    "EnableStun"               INTEGER DEFAULT (0),
		"StunServer" TEXT DEFAULT ('Null'),
		"StunPort" INTEGER DEFAULT (0),
		"StunUserName" TEXT DEFAULT ('Null'),
		"StunPassword" TEXT DEFAULT ('Null'),
		"NatKeepAliveTime" INTEGER DEFAULT (0),
		"NatType" INTEGER DEFAULT (0),
    "DataResUpBandwidth"      INTEGER DEFAULT (0),
    "DataResDownBandwidth"    INTEGER DEFAULT (0),
    "PstnFailOver"             INTEGER DEFAULT (0),
    "FaxPassThru"              INTEGER DEFAULT (0),
    "ModemPassThru"            INTEGER DEFAULT (0),
    "COMMENT" TEXT
);
CREATE TABLE VoiceProfileSignaling (
		"ProfileId" INTEGER DEFAULT (0),
		"EnableProxy" INTEGER DEFAULT (0),
		"EnableRegistrar"  INTEGER DEFAULT (0),
		"ProxyAddr" TEXT DEFAULT ('0'),
		"ProxyPort"  INTEGER DEFAULT (0),
		"ProxyProtocol"  INTEGER DEFAULT (0),
		"RegistrarAddr" TEXT DEFAULT ('Null'),
		"RegistrarPort" INTEGER DEFAULT (0),
		"RegistrarProtocol" INTEGER DEFAULT (0),
		"BackupRegAddr" TEXT DEFAULT ('Null'),
		"BackupRegPort" INTEGER DEFAULT (0),
		"BackupRegProtocol" INTEGER DEFAULT (0),
		"RegExpirationTime" INTEGER DEFAULT (0),
		"RegExpirationTimePercent" INTEGER DEFAULT (0),
		"RegRetryTime" INTEGER DEFAULT (0),
		"RegRetryAttempts" INTEGER DEFAULT (0),
		"UADomain" TEXT DEFAULT ('Null'),
		"DnsQueryTimeOut" INTEGER DEFAULT (0),
		"UAPort" INTEGER DEFAULT (0),
		"UAProtocol"INTEGER DEFAULT (0),
		"OutboundProxyAddr" TEXT DEFAULT ('Null'),
		"OutboundProxyPort" INTEGER DEFAULT (0),
		"WellKnownSource" INTEGER DEFAULT (0),
		"Org" TEXT DEFAULT ('Null'),
		"T1" INTEGER DEFAULT (0),
		"Tk" INTEGER DEFAULT (0),
		"T2" INTEGER DEFAULT (0),
		"T4" INTEGER DEFAULT (0),
		"Ta" INTEGER DEFAULT (0),
		"Tb" INTEGER DEFAULT (0),
		"Tc" INTEGER DEFAULT (0),
		"Td" INTEGER DEFAULT (0),
		"Te" INTEGER DEFAULT (0),
		"Tf" INTEGER DEFAULT (0),
		"Tg" INTEGER DEFAULT (0),
		"Th" INTEGER DEFAULT (0),
		"Ti" INTEGER DEFAULT (0),
		"Tj" INTEGER DEFAULT (0),
		"InvExpires" INTEGER DEFAULT (0),
		"ReInvExpires" INTEGER DEFAULT (0),
		"RegExpires" INTEGER DEFAULT (0),
		"RegMinExpires" INTEGER DEFAULT (0),
		"InboundAuth" INTEGER DEFAULT (0),
		"InbAuthUserName" TEXT DEFAULT ('Null'),
		"InbAuthPassword" TEXT DEFAULT ('Null'),
		"CohMethod" INTEGER DEFAULT (0),
		"UseCompactHdrs" INTEGER DEFAULT (0),
		"UserAgentHdr" TEXT DEFAULT ('Null'),
		"AnnounceMethod" INTEGER DEFAULT (0),
		"SipDscp" INTEGER DEFAULT (0),
		"SipVlanId" INTEGER DEFAULT (0),
		"SipEthPriority" INTEGER DEFAULT (0),
		"COMMENT" TEXT
);
CREATE TABLE VoiceLine (
		"LineId" INTEGER DEFAULT (0),
		"ProfileId" INTEGER DEFAULT (0),
		"AssocVoiceInterface" INTEGER DEFAULT (0),
		"DirName" TEXT DEFAULT ('Null'),
		"Name" TEXT DEFAULT ('Null'),
		"State" INTEGER DEFAULT (0),
		"LineStatus" INTEGER DEFAULT (0),
		"CallStatus" INTEGER DEFAULT (0),
		"GatewayMode" INTEGER DEFAULT (0),
		"LineMode" INTEGER DEFAULT (0),
		"Intrusion" INTEGER DEFAULT (0),
		"COMMENT" TEXT
);
CREATE TABLE VoiceLineSignaling (
		"ProfileId" INTEGER DEFAULT (0),
		"LineId" INTEGER DEFAULT (0),
		"SipUserName" TEXT DEFAULT ('Null'),
		"SipDispName" TEXT DEFAULT ('Null'),
		"NoOfSipAuthCfg" INTEGER DEFAULT (0),
		"COMMENT" TEXT
);
CREATE TABLE AuthCfg (
		"ProfileId" INTEGER DEFAULT (0),
		"LineId" INTEGER DEFAULT (0),
		"Realm" TEXT DEFAULT ('Null'),
		"SipAuthUsrName" TEXT DEFAULT ('Null'),
		"SipAuthPasswd" TEXT DEFAULT ('Null'),
		"COMMENT" TEXT
);
CREATE TABLE DNSSrv (
		"Priority" INTEGER DEFAULT (0),
		"Weight" INTEGER DEFAULT (0),
		"Port" INTEGER DEFAULT (5060),
		"Domain" TEXT DEFAULT ('Null')
);
--BEGIN;
CREATE TABLE wifiRadio
(
	interfaceName  text NOT NULL,
	radioNo  integer NOT NULL,
	cardNo  integer NOT NULL,
	band  text NOT NULL,
	currentChannel  integer NOT NULL,
	configuredChannel  text NOT NULL,
	radioenabled  integer NOT NULL,
	minTxPower  integer,
	maxTxPower  integer,
	txPower  integer NOT NULL,
	path  integer NOT NULL,
	rogueAPEnabled  integer NOT NULL,
	rxDiversity  integer NOT NULL,
    dothEnabled integer NOT NULL,
    dothMaxPower integer NOT NULL,
    dothMarkDfs integer NOT NULL,
    opMode  text NOT NULL,
	beaconInterval  integer NOT NULL,
	dtimInterval  integer NOT NULL,
	rtsThreshold  integer NOT NULL,
	fragThreshold  integer NOT NULL,
	preambleMode  text NOT NULL,
	rtsCtsProtect  integer NOT NULL,
	shortRetry  integer NOT NULL,
	longRetry  integer NOT NULL,
	uapsd  integer NOT NULL,
    chanWidth integer NOT NULL,
    sideBand integer,                       -- 0 (below)/ 1 (above)
    puren integer NOT NULL,                 -- 0 (Disable)/ 1 (Enable)
    mimoPreamble  integer NOT NULL,         -- 0 (for MM) / 1 (for GF)
    rxAntennas  integer,                    -- 0 for auto, 1,2,3
    txAntennas  integer,                    -- 0 for auto, 1,2,3
    radarDetected text,
    subband_515_525   integer,
    subband_525_535   integer,
    subband_547_572   integer,
    subband_572_586   integer,
    ackTimeoutDefault integer,
    ackTimeout        integer,
    radioCost        integer,
    enableAMSDU      integer,
    maxClientsPerRadio  integer,
    bandwidth      text,
	PRIMARY KEY (radioNo),
    FOREIGN KEY (cardNo) REFERENCES dot11Card(cardNo)
)
;

CREATE TABLE wifiInterface
(
    interfaceName  text NOT NULL,
    LogicalIfName  text NOT NULL,
    radioNo  integer NOT NULL,
    wlanName  text NOT NULL,
    macAddress  text NOT NULL,
    PRIMARY KEY (interfaceName),
    FOREIGN KEY (interfaceName) REFERENCES networkInterface(interfaceName),
    FOREIGN KEY (radioNo) REFERENCES wifiRadio(radioNo)
)
;


-- This table is not used.
CREATE TABLE wifiACL
(
	hostName	text,
	macAddress  text NOT NULL,
    wlanName  text NOT NULL,
    PRIMARY KEY (wlanName, macAddress),
    FOREIGN KEY (wlanName) REFERENCES wifiAP(wlanName)
)
;

CREATE TABLE wifiACLconfig
(
    profileName text NOT NULL, -- for index
    ACLPolicy1 integer NOT NULL, -- SSID 1 ACL policy
    ACLPolicy2 integer NOT NULL, -- SSID 2 ACL Policy
    ACLPolicy3 integer NOT NULL, -- SSID 3 ACL Policy, Reserved
    ACLPolicy4 integer NOT NULL, -- SSID 4 ACL Policy, Reserved
    ACLUpdate integer NOT NULL, -- for update table
    PRIMARY KEY (profileName)
)
;


CREATE TABLE wifiACLTable1
(
    ACL_MAC    text NOT NULL,  -- target MAC Address
    comment    text            -- Reserved for ACL comment
)
;

CREATE TABLE wifiACLTable2
(
    ACL_MAC    text NOT NULL,  -- target MAC Address
    comment    text            -- Reserved for ACL comment
)
;
CREATE TABLE wifiACLTable3
(
    ACL_MAC    text NOT NULL,  -- target MAC Address
    comment    text            -- Reserved for ACL comment
)
;
CREATE TABLE wifiACLTable4
(
    ACL_MAC    text NOT NULL,  -- target MAC Address
    comment    text            -- Reserved for ACL comment
)
;


CREATE TABLE wifiAP
(
	wlanName  text NOT NULL,
	wlanEnabled  integer NOT NULL,
	profileName  text ,
	beaconInterval  integer ,
	dtimInterval  integer ,
	maxClients  integer ,
	rtsThreshold  integer ,
	fragThreshold  integer ,
	preambleMode  text ,
	rtsCtsProtect  integer ,
	shortRetry  integer ,
	longRetry  integer ,
	txPower  integer ,
	dot11Mode  text NOT NULL,
	apIsolation  integer ,
    defACLPolicy  text ,
    iappEnabled  integer ,
    uapsd  integer ,
    ucastRate text,
    mcastRate text,
    radioList text, -- we use this only to trigger updates,
                    -- in case radio selection has changed
    WPSEnabled  integer ,  -- 0: disable, 1: no configured, 2: configured
    PRIMARY KEY (wlanName),
    FOREIGN KEY (profileName) REFERENCES wifiProfile(profileName)
)
;

CREATE TABLE wifiProfile
(
	profileName  text NOT NULL,
	ssid  text NOT NULL,
	authserver  text ,
	broadcastSSID  integer NOT NULL,
	pskPassAscii  text ,
	pskPassHex  text ,
	wepkeyPassphrase text,
	wepkey0  text ,
	wepkey1  text ,
	wepkey2  text ,
	wepkey3  text ,
	defWepkeyIdx  integer ,
	groupCipher  text ,
	pairwiseCiphers  text ,
	authMethods  text ,
	security  text NOT NULL,
	authTimeout  integer ,
	assocTimeout  integer ,
	groupKeyUpdateInterval  integer ,
	pmksaLifetime  integer ,
	dot1xReauthInterval  integer ,
	wepAuth  text ,
    preAuthStatus integer NOT NULL,
    qosEnable integer NOT NULL,
	 PRIMARY KEY (profileName)
    --FOREIGN KEY (authserver) REFERENCES radiusClient(authserver)
)
;

CREATE TABLE wifiProfilecommit
(
	profileName text NOT NULL,
	profilecommit integer NOT NULL,
	PRIMARY KEY (profileName)
)
;

CREATE TABLE wifiWPS
(
      profileName  text NOT NULL,
      WPSmethod  text NOT NULL,
      WPSEnrollPIN  text ,
      WPSAPPIN  text ,
      PRIMARY KEY (profileName)
)
;

CREATE TABLE wifiStatus
(
      profileName  text NOT NULL,
      peers1 integer , --SSID 1 connected peers 
      peers2 integer , --SSID 2 connected peers
      peers3 integer , --ac connected peers
      peers4 integer , --reserved
      WPSStatus text , --reserverd
      PRIMARY KEY (profileName)
)
;

CREATE TABLE wifiClient
(
      profileName  text NOT NULL,
      triger integer , -- value is meanless, for trigger the handler.
      PRIMARY KEY (profileName)
)
;
CREATE TABLE wifiAOCSstatus
(
    profileName  text NOT NULL,
    availableCh integer NOT NULL,  --available channel for this country code
    debugFlag integer NOT NULL,    --1: enable debug, 0: disable debug AOCS
    scanTime text,                 -- reserved.      
    AOCSenable  integer NOT NULL,  --1: enable, 0 disable
    PRIMARY KEY (profileName)
)
;

CREATE TABLE wifiAOCSChstatus
(
    profileCh  integer NOT NULL,
    channelFreq text NOT NULL,  --mapping the channel index to channel frequency
    channelLoad integer NOT NULL,  --channel loading.
    visiableAP integer           -- extra AP detected in this channel
)
;

CREATE TABLE wifiAOCStrigger
(
    profileName  text NOT NULL,
    scanTrigger integer NOT NULL, --input arbitrarily value to trigger the channel scan
    PRIMARY KEY (profileName)
)
;


--insert into wifiProfile ('profileName','ssid','broadcastSSID','pskPassAscii','security','preAuthStatus','qosEnable') values ('wlan1','iad2_ap1','iad2_ap1','1234567890','WPA2',0,0);
--insert into wifiProfile ('profileName','ssid','broadcastSSID','pskPassAscii','security','preAuthStatus','qosEnable') values ('wlan2','iad2_ap2','iad2_ap2','1234567890','WPA2',0,0);
--insert into wifiProfile ('profileName','ssid','broadcastSSID','pskPassAscii','security','preAuthStatus','qosEnable') values ('wlan3','iad2_ap3','iad2_ap3','1234567890','WPA2',0,0);
--insert into wifiProfile ('profileName','ssid','broadcastSSID','pskPassAscii','security','preAuthStatus','qosEnable') values ('wlan4','iad2_ap4','iad2_ap4','1234567890','WPA2',0,0);
--COMMIT;
COMMIT;
