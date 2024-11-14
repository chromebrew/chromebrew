require 'package'

class Nginx < Package
  description 'nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.'
  homepage 'http://nginx.org/'
  version '1.26.1'
  license 'BSD-2, BSD, SSLeay, MIT, GPL-2 and GPL-2+'
  compatibility 'all'
  source_url "http://nginx.org/download/nginx-#{version}.tar.gz"
  source_sha256 'f9187468ff2eb159260bfd53867c25ff8e334726237acf227b9e870e53d3e36b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c40c8a04016b5eb44d9705333d67a3858e3bdc7e3d508f56cba3b0d3d8e4ab1',
     armv7l: '3c40c8a04016b5eb44d9705333d67a3858e3bdc7e3d508f56cba3b0d3d8e4ab1',
       i686: 'f744ec2bbeafdb4e9edeacb0a56049dd3068eb1d645865eb92b0656caecac7de',
     x86_64: 'e6261bb676d12132f66514569797d2c02d9cfa1ef2020bffcb6c5349dfcf4b0b'
  })

  depends_on 'pcre'

  print_source_bashrc

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}/share/nginx"
    system 'make'
    File.write 'startnginx', <<~STARTNGINXEOF
      #!/bin/bash
      NGINX=$(ps ax | grep "nginx: master process" | grep -v grep | xargs | cut -d" " -f1 2> /dev/null)
      if [ -z "$NGINX" ]; then
        sudo nginx
      fi
      NGINX=$(ps ax | grep "nginx: master process" | grep -v grep | xargs | cut -d" " -f1 2> /dev/null)
      if [ ! -z "$NGINX" ]; then
        echo "nginx process $NGINX is running"
      else
        echo "nginx failed to start"
        exit 1
      fi
    STARTNGINXEOF
    File.write 'stopnginx', <<~STOPNGINXEOF
      #!/bin/bash
      NGINX=$(ps ax | grep "nginx: master process" | grep -v grep | xargs | cut -d" " -f1 2> /dev/null)
      if [ ! -z "$NGINX" ]; then
        sudo nginx -s quit
      fi
      NGINX=$(ps ax | grep "nginx: master process" | grep -v grep | xargs | cut -d" " -f1 2> /dev/null)
      if [ -z "$NGINX" ]; then
        echo "nginx process stopped"
      else
        echo "nginx process $NGINX is running"
        exit 1
      fi
    STOPNGINXEOF
    File.write '10-nginx', <<~EOF
      #!/bin/bash
      [ -f #{CREW_PREFIX}/bin/startnginx ] && #{CREW_PREFIX}/bin/startnginx
    EOF
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install "#{CREW_DEST_PREFIX}/share/nginx/sbin/nginx", "#{CREW_DEST_PREFIX}/sbin/nginx", mode: 0o755
    FileUtils.install 'startnginx', "#{CREW_DEST_PREFIX}/bin/startnginx", mode: 0o755
    FileUtils.install 'stopnginx', "#{CREW_DEST_PREFIX}/bin/stopnginx", mode: 0o755
    FileUtils.install '10-nginx', "#{CREW_DEST_PREFIX}/etc/bash.d/10-nginx", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      All things NGINX are in #{CREW_PREFIX}/share/nginx.

      Pages are stored in #{CREW_PREFIX}/share/nginx/html.

      To start/stop nginx, execute the following:
      startnginx - starts nginx
      stopnginx - stops nginx
    EOM
  end

  def self.postremove
    if Dir.exist? "#{CREW_PREFIX}/share/nginx"
      puts "\nWARNING: This will remove all hosting files and configuration.".orange
      print "Would you like to remove #{CREW_PREFIX}/share/nginx? [y/N] "
      response = $stdin.gets.chomp.downcase
      case response
      when 'y', 'yes'
        FileUtils.rm_rf "#{CREW_PREFIX}/share/nginx"
        puts "#{CREW_PREFIX}/share/nginx removed.".lightgreen
      else
        puts "#{CREW_PREFIX}/share/nginx saved.".lightgreen
      end
    end
  end
end
