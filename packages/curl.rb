require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.66.0'
  source_url 'https://curl.haxx.se/download/curl-7.66.0.tar.xz'
  source_sha256 'dbb48088193016d079b97c5c3efde8efa56ada2ebf336e8a97d04eb8e2ed98c1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.66.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.66.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.66.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.66.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '135488fd75e5127645d4ffe07d67e635229e5bfdb238852e5d8af9c10fd5f15d',
     armv7l: '135488fd75e5127645d4ffe07d67e635229e5bfdb238852e5d8af9c10fd5f15d',
       i686: 'c03cb9fe9b2d30e106a96a686ce79e367281cea8296241c6151938fcecde27e0',
     x86_64: 'aa67936bd49b3722c356c5fd5137f5b3b350f6085a8da19d70e03ee58f428e60',
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
