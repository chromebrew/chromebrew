require 'package'

class Nginx < Package
  description 'nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.'
  homepage 'http://nginx.org/'
  version '1.11.6-1'
  source_url 'http://nginx.org/download/nginx-1.11.6.tar.gz'
  source_sha1 '51903b721a5ee721568fc59f0a243df5356a98de'
  
  depends_on 'pcre'
  
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "sudo ln -sf /usr/local/nginx/sbin/nginx /usr/local/bin/nginx"
    system "echo all NGINX things are in /usr/local/nginx"
    system "echo pages are in /usr/local/nginx/html"
    system "echo adding bash aliases so you can easily start/stop nginx"
    system "echo startnginx starts nginx and stopnginx stops nginx"
    system "sed -i \'/^alias startnginx/d\' ~/.bashrc"
    system "sed -i \'/^alias stopnginx/d\' ~/.bashrc"
    system "sed -i '$ a alias startnginx=\"sudo nginx\"' ~/.bashrc"
    system "sed -i '$ a alias stopnginx=\"sudo nginx -s quit\"' ~/.bashrc"
  end
end
