

set_unless[:cloudwatch_cli][:url] = "http://ec2-downloads.s3.amazonaws.com/CloudWatch-2010-08-01.zip"
set_unless[:cloudwatch_cli][:install_base] = "/opt/aws"
set_unless[:cloudwatch_cli][:install_dir] = "cloudwatch"
set_unless[:cloudwatch_cli][:user] = "root"
set_unless[:cloudwatch_cli][:group] = "root"

