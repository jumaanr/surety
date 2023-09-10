#To create the KDS root key, run the following command from the Active Directory Module for Windows PowerShell on a Windows Server domain controller
Add-KdsRootKey -EffectiveImmediately
#You create group managed service accounts by using New-ADServiceAccount Windows PowerShell cmdlet with the –PrinicipalsAllowedToRetrieveManagedPassword parameter.
New-ADServiceAccount -Name LondonSQLFarm -PrincipalsAllowedToRetrieveManagedPassword SEA-SQL1, SEA-SQL2, SEA-SQL3

# Active Directory module for Windows PowerShell, displays the forest properties, including the current domain naming master and schema master.
Get-AdForest

#displays the domain properties, including the current RID master, infrastructure master, and PDC emulator master.
Get-ADDomain

#Seize or Transfer Operation Master roles
#Syntax
Move-ADDirectoryServerOperationsMasterRole -Identity "<servername>" -OperationsMasterRole "<rolenamelist>" -Force
<#
servername. The name of the target domain controller to which you are transferring one or more roles.
rolenamelist. A comma-separated list of AD DS role names to move to the target server.
-Force. An optional parameter that you include to seize a role instead of transferring it.
#>

#Example:
    Move-ADDirectoryServerOperationsMasterRole -Identity "DC1" -OperationsMasterRole RIDMaster -Force
    #Transfer multiple FSMO Roles
    Move-ADDirectoryServerOperationsMasterRole -Identity "DC3" -OperationsMasterRole PDCEmulator, InfrastructureMaster -Force

 