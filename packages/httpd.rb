require 'buildsystems/autotools'
require 'convenience_functions'

class Httpd < Autotools
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.63'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/httpd/httpd-#{version}.tar.bz2"
  source_sha256 '88fc236ab99b2864b248de7d49a008ec2afd7551e64dce8b95f58f32f94c46ab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5bb883fd8bbef85f0b4f07f1ea72ae2440aa43f32bf4921866057d3eca044fc',
     armv7l: 'b5bb883fd8bbef85f0b4f07f1ea72ae2440aa43f32bf4921866057d3eca044fc',
     x86_64: 'a26481c3014646418ad74688892a0b48bc0e854158a1891be0ae2ee90a16cf17'
  })

  depends_on 'apr'
  depends_on 'apr_util'
  depends_on 'libtool'
  depends_on 'libxcrypt'
  depends_on 'pcre'
  depends_on 'expat'
  depends_on 'brotli' # R
  depends_on 'glibc' # R
  depends_on 'libnghttp2' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'util_linux' # R
  depends_on 'zlib' # R

  print_source_bashrc

  def self.prebuild
    ConvenienceFunctions.libtoolize('expat')
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
