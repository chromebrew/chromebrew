require 'package'

class Httpd < Package
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.39'
  source_url 'https://www-us.apache.org/dist/httpd/httpd-2.4.39.tar.gz'
  source_sha256 '8b95fe249f3a6c50aad3ca125eef3e02d619116cde242e1bc3c266b7b5c37c30'

  binary_url ({
  })
  binary_sha256 ({
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
