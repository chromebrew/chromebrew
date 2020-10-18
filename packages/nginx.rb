require 'package'

class Nginx < Package
  description 'nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.'
  homepage 'http://nginx.org/'
  version '1.19.3'
  compatibility 'all'
  source_url 'https://nginx.org/download/nginx-1.19.3.tar.gz'
  source_sha256 '91e5b74fa17879d2463294e93ad8f6ffc066696ae32ad0478ffe15ba0e9e8df0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nginx-1.19.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nginx-1.19.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nginx-1.19.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nginx-1.19.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aca948f9c2d22727e0e41fd6f81ac2e2f3775df9a683855dafd2ec664c0f2eb2',
     armv7l: 'aca948f9c2d22727e0e41fd6f81ac2e2f3775df9a683855dafd2ec664c0f2eb2',
       i686: '9dc198322df7652fb39474066516a783f57990c75939fcd906854be05d4ad9dd',
     x86_64: 'c3798879f505b6173e4964105b741a7f5fdf85243562ad70d3b99a405ed1498f',
  })

  depends_on 'pcre'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}/share/nginx"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "ln -s #{CREW_PREFIX}/share/nginx/sbin/nginx nginx"
      system "echo '#!/bin/bash' > startnginx"
      system "echo 'NGINX=\$(ps ax | grep \"nginx: master process\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> startnginx"
      system "echo 'if [ -z \"\$NGINX\" ]; then' >> startnginx"
      system "echo '  sudo nginx' >> startnginx"
      system "echo 'fi' >> startnginx"
      system "echo 'NGINX=\$(ps ax | grep \"nginx: master process\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> startnginx"
      system "echo 'if [ ! -z \"\$NGINX\" ]; then' >> startnginx"
      system "echo '  echo \"nginx process \$NGINX is running\"' >> startnginx"
      system "echo 'else' >> startnginx"
      system "echo '  echo \"nginx failed to start\"' >> startnginx"
      system "echo '  exit 1' >> startnginx"
      system "echo 'fi' >> startnginx"
      system "echo '#!/bin/bash' > stopnginx"
      system "echo 'NGINX=\$(ps ax | grep \"nginx: master process\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> stopnginx"
      system "echo 'if [ ! -z \"\$NGINX\" ]; then' >> stopnginx"
      system "echo '  sudo nginx -s quit' >> stopnginx"
      system "echo 'fi' >> stopnginx"
      system "echo 'NGINX=\$(ps ax | grep \"nginx: master process\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> stopnginx"
      system "echo 'if [ -z \"\$NGINX\" ]; then' >> stopnginx"
      system "echo '  echo \"nginx process stopped\"' >> stopnginx"
      system "echo 'else' >> stopnginx"
      system "echo '  echo \"nginx process \$NGINX is running\"' >> stopnginx"
      system "echo '  exit 1' >> stopnginx"
      system "echo 'fi' >> stopnginx"
      system "chmod +x st*nginx"
    end
  end

  def self.postinstall
    puts
    puts "All things NGINX are in #{CREW_PREFIX}/share/nginx.".lightblue
    puts
    puts "Pages are stored in #{CREW_PREFIX}/share/nginx/html.".lightblue
    puts
    puts "To start/stop nginx, execute the following:".lightblue
    puts "startnginx - starts nginx".lightblue
    puts "stopnginx - stops nginx".lightblue
    puts
    puts "To start nginx on login, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/startnginx ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/startnginx' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To completely remove nginx, perform the following:".lightblue
    puts "crew remove nginx".lightblue
    puts "sudo rm -rf #{CREW_PREFIX}/share/nginx".lightblue
    puts
  end
end
