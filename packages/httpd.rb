require 'buildsystems/autotools'

class Httpd < Autotools
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.66'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/httpd/httpd-#{version}.tar.bz2"
  source_sha256 '94d7ff2b42acbb828e870ba29e4cbad48e558a79c623ad3596e4116efcfea25a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3066b6297164c348ad9f95546c24293dd8c6bf1fd4ac319f1b3b5f88b26bc21',
     armv7l: 'd3066b6297164c348ad9f95546c24293dd8c6bf1fd4ac319f1b3b5f88b26bc21',
     x86_64: '3d3d491a0f0a6776341e96ec123d5179d6fabc2fc190249e7f7f4534213e9f9c'
  })

  depends_on 'apr'
  depends_on 'apr_util'
  depends_on 'brotli' # R
  depends_on 'expat'
  depends_on 'glibc' # R
  depends_on 'libnghttp2' # R
  depends_on 'libtool'
  depends_on 'libxcrypt'
  depends_on 'openssl' # R
  depends_on 'pcre'
  depends_on 'pcre2' # R
  depends_on 'util_linux' # R
  depends_on 'zlib' # R

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
