require 'package'

class Nginx < Package
  version '1.11.6'
  source_url 'http://nginx.org/download/nginx-1.11.6.tar.gz' # software source tarball url
  source_sha1 '51903b721a5ee721568fc59f0a243df5356a98de'  # source tarball sha1 sum

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
    system "sed -i -e '$a\export PATH=$PATH:/usr/local/nginx/sbin' ~/.bashrc"
    system "echo all NGINX things are in /usr/local/nginx"
    system "echo pages are in /usr/local/nginx/html"
    system "echo remember to run nginx as root sudo nginx" 
  end
end
