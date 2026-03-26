require 'package'

class Nginx < Package
  description 'nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.'
  homepage 'http://nginx.org/'
  version '1.29.7'
  license 'BSD-2, BSD, SSLeay, MIT, GPL-2 and GPL-2+'
  compatibility 'all'
  source_url "http://nginx.org/download/nginx-#{version}.tar.gz"
  source_sha256 '673f8fb8c0961c44fbd9410d6161831453609b44063d3f2948253fc2b5692139'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02ad42270f10c44865b65c56581be1c15e0e42300b13f09363a47260001a3631',
     armv7l: '02ad42270f10c44865b65c56581be1c15e0e42300b13f09363a47260001a3631',
       i686: '615700caf252308c4842bbbedb4bdcf7b8b60a018b5409575abeea89bb1971dd',
     x86_64: 'cc732a0c79f473d4aefb44375a3830e40963871d6b113578e08740e754c68a88'
  })

  depends_on 'glibc' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'pcre'
  depends_on 'pcre2' => :executable
  depends_on 'zlib' => :executable

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
