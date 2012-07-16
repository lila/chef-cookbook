Description
===========

Assumes that the EBS volume has been created and "attached" to this instance, then simply mounts it
at specified mount point.

from the http://aws.amazon.com/datasets/3841 :

This data set provides scientists with the opportunity to research and understand this important area of biology. These snapshots includes all the databases that are available at http://www.ensembl.org. Full installation instructions are available at http://www.ensembl.org/info/docs/webcode/install/ensembl-data.html 
Note: The MySQL version of the data set is available here.

Requirements
============

requires the EBS Volume from the snapshot be already attached to the instance

Attributes
==========

mount_point = /data
device = /dev/sdk1

Usage
=====

