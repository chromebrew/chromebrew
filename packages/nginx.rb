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
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_DIR}#{CREW_PREFIX}/bin") do
      system "ln -s #{CREW_PREFIX}/nginx/sbin/nginx nginx"
      system "echo '#!/bin/bash' > startnginx"
      system "echo 'sudo nginx' >> startnginx"
      system "echo '#!/bin/bash' > stopnginx"
      system "echo 'sudo nginx -s quit' >> stopnginx"
      system "chmod +x st*nginx"
    end
    puts
    puts "All things NGINX are in #{CREW_PREFIX}/nginx.".lightblue
    puts
    puts "Pages are stored in #{CREW_PREFIX}/nginx/html.".lightblue
    puts
    puts "Added bash scripts so you can easily start/stop nginx:".lightblue
    puts "startnginx - starts nginx".lightblue
    puts "stopnginx - stops nginx".lightblue
    puts
    puts "To completely remove nginx, perform the following:".lightblue
    puts "crew remove nginx".lightblue
    puts "sudo rm -rf #{CREW_PREFIX}/nginx".lightblue
    puts
  end
end
