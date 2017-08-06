require 'package'

class Nginx < Package
  description 'nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.'
  homepage 'http://nginx.org/'
  version '1.13.3'
  source_url 'https://nginx.org/download/nginx-1.13.3.tar.gz'
  source_sha256 '5b73f98004c302fb8e4a172abf046d9ce77739a82487e4873b39f9b0dcbb0d72'

  depends_on 'pcre'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "sudo ln -sf /usr/local/nginx/sbin/nginx /usr/local/bin/nginx"
    system "sed -i \'/^alias startnginx/d\' ~/.bashrc"
    system "sed -i \'/^alias stopnginx/d\' ~/.bashrc"
    system "sed -i '$ a alias startnginx=\"sudo nginx\"' ~/.bashrc"
    system "sed -i '$ a alias stopnginx=\"sudo nginx -s quit\"' ~/.bashrc"
    puts
    puts "All NGINX things are in /usr/local/nginx.".lightblue
    puts
    puts "Pages are stored in /usr/local/nginx/html.".lightblue
    puts
    puts "Added bash aliases so you can easily start/stop nginx:".lightblue
    puts "startnginx - starts nginx".lightblue
    puts "stopnginx - stops nginx".lightblue
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
