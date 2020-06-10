require 'package'

class Libdsm < Package
  description 'Defective SMb: A minimalist implementation of a client library for SMB using Plain\'Ol C'
  homepage 'https://videolabs.github.io/libdsm/'
  version '0.3.0'
  compatibility 'all'
  source_url 'https://github.com/videolabs/libdsm/releases/download/v0.3.0/libdsm-0.3.0.tar.gz'
  source_sha256 '96caef854a1f7aa61ab6fdfca9c36a1813b37d23d013db0bc4ec7cd38a570b1c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdsm-0.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdsm-0.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdsm-0.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdsm-0.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '03273279d98be86b0da0db0eb251c6a8475dcf32816337bef2aaaecf3f02318d',
     armv7l: '03273279d98be86b0da0db0eb251c6a8475dcf32816337bef2aaaecf3f02318d',
       i686: 'dd47b71fbc2ec25b1d307a426e14d36af75650aa278754b185c7236db83b7068',
     x86_64: '7c42e38967b7b4de66544c4d95d17a0c71b7300e7afdbd70584a7c2f15c62122',
  })

  depends_on 'libtasn1'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
