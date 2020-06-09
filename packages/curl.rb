require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.70.0'
  compatibility 'all'
  source_url 'https://curl.haxx.se/download/curl-7.70.0.tar.xz'
  source_sha256 '032f43f2674008c761af19bf536374128c16241fb234699a55f9fb603fcfbae7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.70.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.70.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.70.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.70.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '267a2e42282fe8d75d2ea5f2b7a85d06a34b002a7f2ee6e5f473a1082bf6b79a',
     armv7l: '267a2e42282fe8d75d2ea5f2b7a85d06a34b002a7f2ee6e5f473a1082bf6b79a',
       i686: '9c1341459a7febb56423108c4a60f0d6c7ea0d616c96fc36b4fbc2e01fe8ff76',
     x86_64: '8a66e93101ff728ef712d05080cfbb028a57f344fe7c4548c01efa2c6ef1d955',
  })

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
