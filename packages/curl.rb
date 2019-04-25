require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.64.1'
  source_url 'https://curl.haxx.se/download/curl-7.64.1.tar.xz'
  source_sha256 '9252332a7f871ce37bfa7f78bdd0a0e3924d8187cc27cb57c76c9474a7168fb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.64.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.64.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.64.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.64.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '19860f4f84b100e306940aebd25c389e64fd87941b02daae842211b5f9ca4123',
     armv7l: '19860f4f84b100e306940aebd25c389e64fd87941b02daae842211b5f9ca4123',
       i686: '1545311084cc3db7252883fc80cb5eb12a0c519dae91cdd96f5a449fa2c278e5',
     x86_64: 'b00a4605990253654ca1a57359d043c614a8e28acab6981c344ff2b45c5ff3ea',
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
