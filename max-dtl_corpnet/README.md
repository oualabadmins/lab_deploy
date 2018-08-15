# MAXLAB DTL (DevTest Lab) - Corpnet (v1.0)

**IMPORTANT**: Only deploy this template into a subscription with an existing ExpressRoute circuit, and to a region with an ER circuit. The template will automatically choose the correct ER virtual network based on subscription and region.

**Choose one of these subscription/region combinations:**

| Subscription             | Region(s)
| :-------------------     | :-------------------
| MAXLAB R&D Self Service (preferred)  | South Central US <br> West Central US
| MAXLAB R&D INT 1         | West US 2 <br> West Central US
| MAXLAB R&D INT 2         | West US 2

**Time to deploy**: 1.5 minutes

The **MAXLAB DTL (DevTest Lab) - Corpnet** provisions a DevTest lab with formulas and a connection to the GitHub DTL artifacts repo.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-dtl_corpnet%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-dtl_corpnet%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

Click the "Deploy to Azure" button to open the deployment UI in the Azure portal.

To get the User ID for the _RbacUser_ field, run the following cmdlet in an elevated PowerShell console:

```powershell
Get-AzureRmADUser -UserPrincipalName <alias>@microsoft.com | select Id
```

To get a PAT (Personal Access Token) for the artifact repository, either use the PAT **DTL Artifact Repo** in the lab OneNote at [GitHub Tokens/PATs](https://microsoft.sharepoint.com/teams/OSS_Content_Team_Virtual_Lab_Support/admin/_layouts/OneNote.aspx?id=%2Fteams%2FOSS_Content_Team_Virtual_Lab_Support%2Fadmin%2FSiteAssets%2FLab%20Admin%20Notebook&wd=target%28Azure.one%7C3CE891CD-4AF4-4F1A-8EEF-75B25022E9BE%2FGitHub%20Tokens%5C%2FPATs%7C560AF958-1C3B-410E-8838-584CDAE16051%2F%29), or create a new PAT with full access to the repo.

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **DevTest lab** with the essential library of MAX Skunkworks formulas and artifacts.
+ **Key vault**
+ **Storage account**
+ **User role assignment** that adds the user you specify in the **RbacUsername** parameter to the _Owners_ role of the resource group.

## Solution notes

## Known issues

`Tags: DevTest`
___
Developed by the **MAX Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Last update: _8/14/2018_

## Changelog

+ **8/14/2018**: Original commit. Updated with access to ARM templates from lab_deploy.