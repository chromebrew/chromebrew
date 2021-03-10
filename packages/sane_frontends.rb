require 'package'

class Sane_frontends < Package
  description 'Scanner Access Now Easy - Frontends'
  homepage 'http://www.sane-project.org/'
  version '5729'
  compatibility 'all'
  source_url 'https://gitlab.com/sane-project/frontends/-/archive/572980c81586c114fd66fc473c634b4b2780cda2/frontends-572980c81586c114fd66fc473c634b4b2780cda2.tar.bz2'
  source_sha256 'c58a2066891428c6e6c6f625b595e3ada8b36dfe69250b1bbdaded91d76b094f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sane_frontends-5729-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sane_frontends-5729-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sane_frontends-5729-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sane_frontends-5729-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2ccfe4f3af211f4132015436d57f65a59d9d011d73ad4919cb0fb7d2555d2d48',
     armv7l: '2ccfe4f3af211f4132015436d57f65a59d9d011d73ad4919cb0fb7d2555d2d48',
       i686: '4ede64326112d776b179874c889484b6fedd0dc2b5203fbb99eadad1b03ca1e8',
     x86_64: 'd019012cc57c3212db24418df945a7dbf078ace549e875cbf312d19e0d4a8f44'
  })

  depends_on 'sane_backends'

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
