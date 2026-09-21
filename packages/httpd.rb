require 'buildsystems/autotools'

class Httpd < Autotools
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.68'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/httpd/httpd-#{version}.tar.bz2"
  source_sha256 '68c74d4df38c26bed4dfbdb8f3baf1eb532f3872357becc1bba5d136f6b63c06'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71ea714072f6705b30e4dee5db9f4935c283adb37ba3adb51ab9e87ec7982ba8',
     armv7l: '71ea714072f6705b30e4dee5db9f4935c283adb37ba3adb51ab9e87ec7982ba8',
     x86_64: '87fa90f146bf0a31121acd1f23943177f1895f4210e057cfb8405522d5d3feff'
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
