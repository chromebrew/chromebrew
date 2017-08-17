require 'package'

class Nginx < Package
  description 'nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.'
  homepage 'http://nginx.org/'
  version '1.13.4'
  source_url 'https://nginx.org/download/nginx-1.13.4.tar.gz'
  source_sha256 'de21f3c49ba65c611329d8759a63d72e5fcf719bc6f2a3270e2541348ef1fbba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nginx-1.13.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nginx-1.13.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nginx-1.13.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nginx-1.13.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '16ebf8f5650a505f59eb1113b9ec93749f443578b89d2addf9bd97d818cde2b5',
     armv7l: '16ebf8f5650a505f59eb1113b9ec93749f443578b89d2addf9bd97d818cde2b5',
       i686: '2b0745298ceb8d088384c96dc7c94d4dff423b67e0755519e7d9d2bc3b8f4f5b',
     x86_64: '6de690f574ce766db4cc52c172861337b6a74fdc70bf9b7b1c354b9156ec85f2',
  })

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
