require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.66.0-1'
  source_url 'https://curl.haxx.se/download/curl-7.66.0.tar.xz'
  source_sha256 'dbb48088193016d079b97c5c3efde8efa56ada2ebf336e8a97d04eb8e2ed98c1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.66.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.66.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.66.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.66.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd3fa586deef7030c2bdd3c3e477391c276b34276d5dddbf755cf4785a56ec482',
     armv7l: 'd3fa586deef7030c2bdd3c3e477391c276b34276d5dddbf755cf4785a56ec482',
       i686: '76dfc54131f9ad33fdc6fba5ffc74eabd730322ba88cfdf10ded79b304c1ce22',
     x86_64: 'bee317b81814d931317a7539cd86678e28b3de46508aa09ad7a5aa648ba761ff',
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
