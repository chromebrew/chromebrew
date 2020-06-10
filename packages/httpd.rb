require 'package'

class Httpd < Package
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.39'
  compatibility 'all'
  source_url 'https://www-us.apache.org/dist/httpd/httpd-2.4.39.tar.gz'
  source_sha256 '8b95fe249f3a6c50aad3ca125eef3e02d619116cde242e1bc3c266b7b5c37c30'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.39-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.39-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.39-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.39-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '15fa2c35305494c0c3b24a71ec3789de9c8fe4336e7c0b034a86b7b373826561',
     armv7l: '15fa2c35305494c0c3b24a71ec3789de9c8fe4336e7c0b034a86b7b373826561',
       i686: '3d8937240110d1ae00cd8d5470c75eb8befa04156dd3f849a667f126d3d7d767',
     x86_64: '77bacdd6568a4f1e92eee142f3cce379bc71f3228fb5459ef53580e80676714a',
  })

  depends_on 'apr'
  depends_on 'aprutil'
  depends_on 'libtool'
  depends_on 'pcre'
  depends_on 'expat'

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
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "All things HTTPD are in #{CREW_PREFIX}/share/httpd.".lightblue
    puts
    puts "Pages are stored in #{CREW_PREFIX}/share/httpd/htdocs.".lightblue
    puts
    puts "To start/stop httpd, execute the following:".lightblue
    puts "sudo apachectl start - starts httpd".lightblue
    puts "sudo apachectl stop - stops httpd".lightblue
    puts
    puts "To start httpd on login, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/apachectl ]; then' >> ~/.bashrc".lightblue
    puts "echo '  sudo #{CREW_PREFIX}/bin/apachectl start' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To completely remove httpd, perform the following:".lightblue
    puts "crew remove httpd".lightblue
    puts "sudo rm -rf #{CREW_PREFIX}/share/httpd".lightblue
    puts
  end
end
