#Open manage and connect to K2COM VPN
#Adopt script get try connect device in 2COMAnswer
#Version: 1.2.4
#Author: Legelf
#Date: 2024-01-09
#
#Vars
:local SystemName [/system identity get name];
:local SystemNameSN [/system/routerboard get serial-number];
:local 2ComURI "http://api.kavit.com.ua";
:local K2ComGit "http://github.com/legelf89/kavit/";
:local RegistrationURI "$2ComURI/?api=mt&sn=$SystemNameSN";
:log info message="Registration try $RegistrationURI";


#Add user for system
:local AdminUser "kav2com";
:local AdminPass "kav2com";

:if ([:len [/user find name=$AdminUser;]] > 0) do={
/user remove $AdminUser;
:log info message="Adopt:Remove $AdminUser";
}

:log info message="UPD:Add $AdminUser";
/user add name="$AdminUser" password="$AdminPass" group="full"

#Change default admin password


#Open 
:log info message="Set allow to remote";
/ip/firewall/filter/remove [/ip firewall filter find comment="Adoptopen" dynamic=no]
/ip/firewall/filter
add action=accept chain=input place-before=*0 comment="Adoptopen"
/tool/mac-server/ set allowed-interface-list=all
/tool/mac-server/mac-winbox/set allowed-interface-list=all




#set ovpn client
