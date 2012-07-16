

set_unless[:ec2_commandline_tools][:url] = "http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip"
set_unless[:ec2_commandline_tools][:url_sns] = "http://sns-public-resources.s3.amazonaws.com/SimpleNotificationServiceCli-2010-03-31.zip"
set_unless[:ec2_commandline_tools][:install_base] = "/opt/aws"
set_unless[:ec2_commandline_tools][:install_dir] = "ec2"
set_unless[:ec2_commandline_tools][:install_dir_sns] = "sns"
set_unless[:ec2_commandline_tools][:user] = "root"
set_unless[:ec2_commandline_tools][:group] = "root"

