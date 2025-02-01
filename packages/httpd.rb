require 'buildsystems/autotools'
require 'convenience_functions'

class Httpd < Autotools
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.63'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/httpd/httpd-#{version}.tar.bz2"
  source_sha256 '88fc236ab99b2864b248de7d49a008ec2afd7551e64dce8b95f58f32f94c46ab'
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

  configure_build_extras do
    File.write '10-httpd', <<~EOF
      #!/bin/bash
      [ -f #{CREW_PREFIX}/bin/apachectl ] && sudo #{CREW_PREFIX}/bin/apachectl start
    EOF
  end

  configure_options "--prefix=#{CREW_PREFIX}/share/httpd \
    --libdir=#{CREW_LIB_PREFIX} \
    --bindir=#{CREW_PREFIX}/bin \
    --sbindir=#{CREW_PREFIX}/bin \
    --disable-maintainer-mode \
    --disable-debugger-mode"

  configure_install_extras do
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
