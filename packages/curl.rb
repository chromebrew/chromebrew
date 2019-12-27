require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.67.0'
  source_url 'https://curl.haxx.se/download/curl-7.67.0.tar.xz'
  source_sha256 'f5d2e7320379338c3952dcc7566a140abb49edb575f9f99272455785c40e536c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.67.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.67.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.67.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.67.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ae1098c3ab701d280fcef2266fd55d89c7c2b258a2a54141ad01abdaa394f54',
     armv7l: '5ae1098c3ab701d280fcef2266fd55d89c7c2b258a2a54141ad01abdaa394f54',
       i686: '497a670dbe39877b48916f3545d6a75b855624635e6c93806bd47c9280d3e490',
     x86_64: '1c12008aa3b2c72084b2bae2c8e4c3246dc8358e25222c159ddf24ec0776ae5c',
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
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-dependency-tracking',
      '--disable-maintainer-mode',
      '--enable-libcurl-option',
      '--with-libmetalink',
      '--disable-static',
      '--disable-debug',
      '--with-libssh2',
      '--with-nghttp2',
      '--with-brotli',
      '--enable-ldap',
      '--with-ssl'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

end
