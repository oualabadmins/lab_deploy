# Deploy an Ubuntu Mate Desktop VM with ROS Robotics

Updated by kelleyvice-msft on 7/24/2018

This template creates a ROS developer workstation as follows:

- Create a VM based on the Ubuntu 16.04 image with Mate Desktop
- Installs Azure CLI v2
- Install Visual Studio Code editor
- Install ROS Kinetic, Gazebo, RViz and MoveIt (robotics dev env)
- Opens the RDP port for users to connect using remote desktop

This template creates a new Ubuntu VM with Mate desktop enabled. The template also installs developer tools for ROS robotics development. Users can connect to the Desktop UI using remote destop at port 3389.

To connect, run "mstsc" from windows desktop and connect to the fqdn/public ip of the VM.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fkvice-working%2Fubuntu-mate-desktop-vscode%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>