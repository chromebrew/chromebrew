require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.64.0'
  source_url 'https://curl.haxx.se/download/curl-7.64.0.tar.xz'
  source_sha256 '2f2f13fa34d44aa29cb444077ad7dc4dc6d189584ad552e0aaeb06e608af6001'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.64.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.64.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.64.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.64.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e3123c63a71a6a326f722c4c43d0c2f872e6dd98f2a5aa48eed5e7a5f2cebd4d',
     armv7l: 'e3123c63a71a6a326f722c4c43d0c2f872e6dd98f2a5aa48eed5e7a5f2cebd4d',
       i686: '63ae5ac6beaf62b07efb626e73f66e6ee60e650242cc1d56f874c780b3110411',
     x86_64: '68b0f48be8feefe01582c7fe05ef549d0fd63b581ab5d2821226f5d04c6c3dbe',
  })

  depends_on 'groff' => :build
  depends_on 'brotli'
  depends_on 'libmetalink'
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
      '--with-brotli',
      '--enable-ldap',
      '--with-ssl'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
#    system 'make', 'test'
  end
end
