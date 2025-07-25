require 'buildsystems/autotools'

class Httpd < Autotools
  description 'The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows.'
  homepage 'https://httpd.apache.org/'
  version '2.4.65'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/httpd/httpd-#{version}.tar.bz2"
  source_sha256 '58b8be97d9940ec17f7656c0c6b9f41b618aac468b894b534148e3296c53b8b3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16d59178572a71110bc76e5a961a9234cf023c7ccf7482fbf3bd1e2e8543a170',
     armv7l: '16d59178572a71110bc76e5a961a9234cf023c7ccf7482fbf3bd1e2e8543a170',
     x86_64: 'b82d2fa47b64caae72c223a1b71670e4c035c545cc5dc547dcd51c6c7a2e472f'
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
