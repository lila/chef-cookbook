Description
===========

StarCluster is software for spinning up and managing traditional HPC Clusters on AWS.  See
http://web.mit.edu/starcluster 
for more details.  A copy of the description is here:

StarCluster is a utility for creating and managing computing clusters hosted on Amazon's Elastic Compute Cloud (EC2). StarCluster utilizes Amazon's EC2 web service to create and destroy clusters of Linux virtual machines on demand.

To get started, the user creates a simple configuration file with their AWS account details and a few cluster preferences (e.g. number of machines, machine type, ssh keypairs, etc). After creating the configuration file and running StarCluster's "start" command, a cluster of Linux machines configured with the Sun Grid Engine queuing system, an NFS-shared /home directory, and OpenMPI with password-less ssh is created and ready to go out-of-the-box. Running StarCluster's "stop" command will shutdown the cluster and stop paying for service. This allows the user to only pay for what they use.

StarCluster can also utilize Amazon's Elastic Block Storage (EBS) volumes to provide persistent data storage for a cluster. EBS volumes allow you to store large amounts of data in the Amazon cloud and are also easy to back-up and replicate in the cloud. StarCluster will mount and NFS-share any volumes specified in the config. StarCluster's "createvolume" command provides the ability to automatically create, format, and partition new EBS volumes for use with StarCluster.

StarCluster provides a Ubuntu-based Amazon Machine Image (AMI) in 32bit and 64bit architectures. The AMI contains an optimized NumPy/SciPy/Atlas/Blas/Lapack installation compiled for the larger Amazon EC2 instance types. The AMI also comes with Sun Grid Engine (SGE) and OpenMPI compiled with SGE support. The public AMI can easily be customized by launching a single instance of the public AMI, installing additional software on the instance, and then using StarCluster's "createimage" command to completely automate the process of creating a new AMI from an EC2 instance.

Requirements
============

Amazon AWS Account
Python 2.5+
Boto 2.0
Paramiko 1.7.7.1
WorkerPool 0.9.2
Jinja2 2.5.5
decorator 3.3.1

Attributes
==========


Usage
=====

