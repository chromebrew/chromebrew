require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.34'
  source_url 'https://sourceforge.net/projects/libpng/files/libpng16/1.6.34/libpng-1.6.34.tar.xz'
  source_sha256 '2f1e960d92ce3b3abd03d06dfec9637dfbd22febf107a536b44f7a47c60659f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.34-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.34-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.34-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.34-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '380cd321d5abdbda55f3941e7ebeccccbe2b4618d939ca3e8bb80f13c229fc68',
     armv7l: '380cd321d5abdbda55f3941e7ebeccccbe2b4618d939ca3e8bb80f13c229fc68',
       i686: 'b7ec1bfc198559a3568add4351eea4f9f05d35dcf97af57df017e2355e5e7234',
     x86_64: '172fa194c4a7e185a9bacf7a1932c6dcf71ce0a3d19990fd10a39ee9f6a2171a',
  })

  depends_on 'zlibpkg'

  def self.build
      system './configure',
        "--prefix=#{CREW_PREFIX}",
        "--libdir=#{CREW_LIB_PREFIX}",
        '--disable-dependency-tracking',
        '--disable-maintainer-mode'
      system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
