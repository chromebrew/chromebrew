require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.72.0'
  compatibility 'all'
  source_url 'https://curl.haxx.se/download/curl-7.72.0.tar.xz'
  source_sha256 '0ded0808c4d85f2ee0db86980ae610cc9d165e9ca9da466196cc73c346513713'


  depends_on 'groff' => :build
  depends_on 'brotli'
  depends_on 'libmetalink'
  depends_on 'libnghttp2'
  depends_on 'libtirpc'
  depends_on 'openldap'
  depends_on 'rtmpdump'

  def self.build
    ENV['LIBRARY_PATH'] = CREW_LIB_PREFIX
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --enable-libcurl-option --with-libmetalink \
--disable-static --disable-debug --with-libssh2 --with-nghttp2 --with-brotli --enable-ldap --with-ssl"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

end
