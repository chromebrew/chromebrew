require 'package'

class Nginx < Package
  description 'nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.'
  homepage 'http://nginx.org/'
  version '1.28.0'
  license 'BSD-2, BSD, SSLeay, MIT, GPL-2 and GPL-2+'
  compatibility 'all'
  source_url "http://nginx.org/download/nginx-#{version}.tar.gz"
  source_sha256 'c6b5c6b086c0df9d3ca3ff5e084c1d0ef909e6038279c71c1c3e985f576ff76a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93030fc62703df474505ee6d7ed6805d374021ad4cb957583960f596cf6b7c64',
     armv7l: '93030fc62703df474505ee6d7ed6805d374021ad4cb957583960f596cf6b7c64',
       i686: 'bc62cbfc1bd1dd9bd19506ac1935c130a1332c072052e07ec864c537e17261f4',
     x86_64: 'b8c77ef02eeabb500226160755c2f9d165e6d7d74aedb7de2e10d45761cf9ac8'
  })

  depends_on 'pcre'
  depends_on 'glibc' # R
  depends_on 'pcre2' # R
  depends_on 'zlib' # R

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
    puts "\nWARNING: This will remove all hosting files and configuration.".orange
    Package.agree_to_remove("#{CREW_PREFIX}/share/nginx")
  end
end
