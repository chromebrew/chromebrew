require 'package'

class Nginx < Package
  description 'nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.'
  homepage 'http://nginx.org/'
  version '1.19.6'
  license 'BSD-2, BSD, SSLeay, MIT, GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://nginx.org/download/nginx-1.19.6.tar.gz'
  source_sha256 'b11195a02b1d3285ddf2987e02c6b6d28df41bb1b1dd25f33542848ef4fc33b5'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nginx/1.19.6_armv7l/nginx-1.19.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nginx/1.19.6_armv7l/nginx-1.19.6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nginx/1.19.6_i686/nginx-1.19.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nginx/1.19.6_x86_64/nginx-1.19.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '12c999e173d529e09e73651be3da52e10c330292bb77b5f1091754470622f32c',
     armv7l: '12c999e173d529e09e73651be3da52e10c330292bb77b5f1091754470622f32c',
       i686: '5655869f1c9bc543734be534fa1528957a031a2946c0a01847fdf582a680001e',
     x86_64: '82fd389650190b29f398b9430e34d92441c0071d39be8a5fa327b8035aa8e7a2'
  })

  depends_on 'pcre'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}/share/nginx"
    system 'make'
    @startnginx = <<~STARTNGINXEOF
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
    File.write('startnginx', @startnginx)
    @stopnginx = <<~STOPNGINXEOF
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
    File.write('stopnginx', @stopnginx)
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'startnginx', "#{CREW_DEST_PREFIX}/bin/startnginx", mode: 0o755
    FileUtils.install 'stopnginx', "#{CREW_DEST_PREFIX}/bin/stopnginx", mode: 0o755
  end

  def self.postinstall
    puts
    puts "All things NGINX are in #{CREW_PREFIX}/share/nginx.".lightblue
    puts
    puts "Pages are stored in #{CREW_PREFIX}/share/nginx/html.".lightblue
    puts
    puts 'To start/stop nginx, execute the following:'.lightblue
    puts 'startnginx - starts nginx'.lightblue
    puts 'stopnginx - stops nginx'.lightblue
    puts
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/startnginx ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/startnginx' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
  end

  def self.remove
    if Dir.exist? "#{CREW_PREFIX}/share/nginx"
      puts
      print "Would you like to remove #{CREW_PREFIX}/share/nginx? [y/N] "
      response = $stdin.gets.chomp.downcase
      case response
      when 'y', 'yes'
        FileUtils.rm_rf "#{CREW_PREFIX}/share/nginx"
        puts "#{CREW_PREFIX}/share/nginx removed.".lightred
      else
        puts "#{CREW_PREFIX}/share/nginx saved.".lightgreen
      end
      puts
    end
  end
end
