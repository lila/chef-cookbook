

set_unless[:ping][:url] = "http://s3.amazonaws.com/karanb.aspera.demo/ping_server.tgz"
set_unless[:ping][:install_base] = "/opt"
set_unless[:ping][:install_dir] = "ping"
set_unless[:ping][:user] = "root"
set_unless[:ping][:group] = "root"

