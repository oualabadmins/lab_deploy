# Skunkworks Lab - DTL (DevTest Lab) - Corpnet (v1.0)

**IMPORTANT**: Only deploy this template into a subscription with an existing ExpressRoute circuit, and to a region with an ER circuit. The template will automatically choose the correct ER virtual network based on subscription and region.

**Choose one of these subscription/region combinations:**

| Subscription             | Region(s)
| :-------------------     | :-------------------
| MAXLAB R&D Self Service  | West Central US
| MAXLAB R&D INT 1         | West US 2 <br> West Central US
| MAXLAB R&D INT 2 (preferred) | West US 2

**Time to deploy**: ~3 minutes

The **MAXLAB DTL (DevTest Lab) - Corpnet** provisions a complete DevTest lab on a corpnet-connected ER circuit with formulas and a connection to the GitHub DTL artifact and ARM template repos. If you specify a user ID for the **RbacUser** parameter, that user will be added to the resource group's _Owners_ role.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-dtl_corpnet%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-dtl_corpnet%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

Click the "Deploy to Azure" button to open the deployment UI in the Azure portal.

+ The user account you specify for the _domainUsername_ parameter should be a service account in the corporate domain. This account is consumed by artifacts that require domain authentication, such as joining a computer to the domain.
+ To get the User ID for the _RbacUser_ field, run the following cmdlet in an elevated PowerShell console:

    ```powershell
    Get-AzureRmADUser -UserPrincipalName <alias>@microsoft.com | select Id
    ```

+ To get a PAT (Personal Access Token) for the artifact repository, either use the PAT **DTL Artifact Repo** in the lab OneNote at [GitHub Tokens/PATs](https://microsoft.sharepoint.com/teams/OSS_Content_Team_Virtual_Lab_Support/admin/_layouts/OneNote.aspx?id=%2Fteams%2FOSS_Content_Team_Virtual_Lab_Support%2Fadmin%2FSiteAssets%2FLab%20Admin%20Notebook&wd=target%28Azure.one%7C3CE891CD-4AF4-4F1A-8EEF-75B25022E9BE%2FGitHub%20Tokens%5C%2FPATs%7C560AF958-1C3B-410E-8838-584CDAE16051%2F%29), or create a new PAT with full access to the repo.

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **DevTest lab** with the essential library of MAX Skunkworks formulas and artifacts, including access to ARM templates you can deploy in the lab.
+ **Key vault**
+ **Storage account**
+ **User role assignment** that adds the user you specify in the **RbacUsername** parameter to the _Owners_ role of the resource group.

## Solution notes

## Known issues

`Tags: DevTest`
___
Developed by the **MARVEL Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](../common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Last update: _9/19/2018_

## Changelog

+ **8/14/2018**: Original commit. Updated with access to ARM templates from lab_deploy.
