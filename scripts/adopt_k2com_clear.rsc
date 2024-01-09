#Open manage and connect to K2COM VPN
#Adopt script get try connect device in 2COMAnswer
#Version: 1.2.4
#Author: Legelf
#Date: 2024-01-09
#URI: https://raw.githubusercontent.com/legelf89/kavit/main/scripts/adopt_k2com_clear.rsc
#
#Vars
:local SystemName [/system identity get name];
:local SystemNameSN [/system/routerboard get serial-number];
:local K2ComGitURI "https://raw.githubusercontent.com/legelf89/kavit/main/scripts/";
#
:log info message="Try fetch script from public git";
/tool/fetch url="https://raw.githubusercontent.com/legelf89/kavit/main/scripts/adopt_k2com_clear.rsc" mode=https


#Add user for system
:local AdminUser "kav2com";
:local AdminPass "kav2com";

:if ([:len [/user find name=$AdminUser;]] > 0) do={
/user remove $AdminUser;
:log info message="Adopt:Remove $AdminUser";
}
:log info message="UPD:Add $AdminUser";
/user add name="$AdminUser" password="$AdminPass" group="full"





#Open 
:log info message="Set allow to remote";
/ip/firewall/filter/remove [/ip firewall filter find comment="Adoptopen" dynamic=no]
/ip/firewall/filter
add action=accept chain=input place-before=*0 comment="Adoptopen"
/tool/mac-server/ set allowed-interface-list=all
/tool/mac-server/mac-winbox/set allowed-interface-list=all


#Change default admin password

#set ovpn client
