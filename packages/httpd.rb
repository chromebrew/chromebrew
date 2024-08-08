require 'package'

class Httpd < Package
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.62'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/httpd/httpd-#{version}.tar.bz2"
  source_sha256 '674188e7bf44ced82da8db522da946849e22080d73d16c93f7f4df89e25729ec'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'caa26002fba12159774416d6b664ceeba7ae918e11f63302d4e4ed8ba3c886af',
     armv7l: 'caa26002fba12159774416d6b664ceeba7ae918e11f63302d4e4ed8ba3c886af',
       i686: '6cdfb3f1bea82821c21aa1da2b7b285950bcc6efd89fda5eac2b994f6293a712',
     x86_64: 'ed25f5ab36847c6c88f9e18d314eb6a595bc8d7f5ec4657b1a7317bf3ec2c6c1'
  })

  depends_on 'apr'
  depends_on 'apr_util'
  depends_on 'libtool'
  depends_on 'libxcrypt'
  depends_on 'pcre'
  depends_on 'expat'

  print_source_bashrc

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}/share/httpd",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--bindir=#{CREW_PREFIX}/bin",
           "--sbindir=#{CREW_PREFIX}/bin",
           '--disable-maintainer-mode',
           '--disable-debugger-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/10-httpd", <<~EOF
      #!/bin/bash
      [ -f #{CREW_PREFIX}/bin/apachectl ] && sudo #{CREW_PREFIX}/bin/apachectl start
    EOF
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      All things HTTPD are in #{CREW_PREFIX}/share/httpd.

      Pages are stored in #{CREW_PREFIX}/share/httpd/htdocs.

      To start/stop httpd, execute the following:
      sudo apachectl start - starts httpd
      sudo apachectl stop - stops httpd
    EOM
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/share/httpd"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all hosting files and configuration.'.orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
