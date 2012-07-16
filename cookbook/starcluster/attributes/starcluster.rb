
set_unless[:starcluster][:access_key_id] = "xxx"
set_unless[:starcluster][:secret_access_key] = "xxx"
set_unless[:starcluster][:account_number] = "xxx"
set_unless[:starcluster][:ensembl_volume] = "xxx"
set_unless[:starcluster][:cluster_keypair] = "rsa-normal"

set_unless[:starcluster][:version] = "0.93"
set_unless[:starcluster][:remotefile] = "starcluster-" + node[:starcluster][:version] + ".tar.gz"
set_unless[:starcluster][:url] = "http://web.mit.edu/star/media/uploads/cluster/downloads/" + node[:starcluster][:remotefile]
set_unless[:starcluster][:install_base] = "/opt"
set_unless[:starcluster][:install_dir] = "starcluster"
