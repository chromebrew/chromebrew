require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.66.0'
  source_url 'https://curl.haxx.se/download/curl-7.66.0.tar.xz'
  source_sha256 'dbb48088193016d079b97c5c3efde8efa56ada2ebf336e8a97d04eb8e2ed98c1'

  binary_url ({
  })
  binary_sha256 ({
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
