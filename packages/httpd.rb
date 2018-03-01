require 'package'

class Httpd < Package
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'http://httpd.apache.org/'
  version '2.4.29'
  source_url 'https://www-us.apache.org/dist/httpd/httpd-2.4.29.tar.gz'
  source_sha256 '948e4a11278a5954698b880b30f401b1e9ab743713ee2c7280a54dd4ddd87085'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/httpd-2.4.29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0e2bc1862b7864e933678c053ebabb326560b64535f595c9be0f76fa4798a57',
     armv7l: 'f0e2bc1862b7864e933678c053ebabb326560b64535f595c9be0f76fa4798a57',
       i686: 'b5b0627d53bb7305996c674b03ec1070f1cf32c61771af241672ff75949150b3',
     x86_64: '6a7f76c58667d384c149a215e114be5a087e4544b67a6864d293bae4221c6215',
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
