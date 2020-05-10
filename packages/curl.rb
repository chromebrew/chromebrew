require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.69.1'
  compatibility 'all'
  source_url 'https://curl.haxx.se/download/curl-7.69.1.tar.xz'
  source_sha256 '03c7d5e6697f7b7e40ada1b2256e565a555657398e6c1fcfa4cb251ccd819d4f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.69.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.69.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.69.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.69.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '991776840afbdf259a7d0e2c04669cfdbc6732f99c1f967541ede6be8d4b3623',
     armv7l: '991776840afbdf259a7d0e2c04669cfdbc6732f99c1f967541ede6be8d4b3623',
       i686: '62ed095da0b4344ef7e6d73d474d76899a5d8c3c62b8b337159d2707e5b494b3',
     x86_64: 'ad171822283ad474aa1235ce385541c66e08f299441d6e0d718b2272c5e56cbf',
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
