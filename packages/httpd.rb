require 'buildsystems/autotools'

class Httpd < Autotools
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.71'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/httpd/httpd-#{version}.tar.bz2"
  source_sha256 '2bc5da5a33c247341de082717d4ebcb5cb49e8b73a05b7fddf7d5d6dc2f8de62'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6f12e50c6ac55e4bb38d0c126fff398aad435627759e914110c37dd6f365ed5',
     armv7l: 'a6f12e50c6ac55e4bb38d0c126fff398aad435627759e914110c37dd6f365ed5',
     x86_64: 'e36eb83704c1b2f8d84f28b772df487ecb03ccc478d4325af7952b52531a76f9'
  })

  depends_on 'apr' => :executable
  depends_on 'apr_util' => :executable
  depends_on 'brotli' => :library
  depends_on 'expat' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libnghttp2' => :library
  depends_on 'libtool' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'openssl' => :library
  depends_on 'pcre' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'util_linux' => :library
  depends_on 'zlib' => :library

  print_source_bashrc

  def self.prebuild
    ConvenienceFunctions.libtoolize('expat')
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end

  autotools_build_extras do
    File.write '10-httpd', <<~EOF
      #!/bin/bash
      [ -f #{CREW_PREFIX}/bin/apachectl ] && sudo #{CREW_PREFIX}/bin/apachectl start
    EOF
  end

  autotools_configure_options "--prefix=#{CREW_PREFIX}/share/httpd \
    --bindir=#{CREW_PREFIX}/bin \
    --sbindir=#{CREW_PREFIX}/bin \
    --disable-maintainer-mode \
    --disable-debugger-mode"

  autotools_install_extras do
    FileUtils.install '10-httpd', "#{CREW_PREFIX}/etc/bash.d/10-httpd", mode: 0o755
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

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/share/httpd")
  end
end
