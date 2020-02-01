require 'package'

class Libgphoto < Package
  description 'The libgphoto2 camera access and control library.'
  homepage 'http://www.gphoto.org/'
  version '2.5.23'
  source_url 'https://github.com/gphoto/libgphoto2/archive/libgphoto2-2_5_23-release.tar.gz'
  source_sha256 '8de52fd997aceda895abad5d8d95a888bce24a1c739079cff64dae1da7039dde'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgphoto-2.5.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgphoto-2.5.23-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgphoto-2.5.23-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgphoto-2.5.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dfb2080fbbd42cfffdc05a6bb6d52775b807825d1b3b7ca18934c70d88beb1be',
     armv7l: 'dfb2080fbbd42cfffdc05a6bb6d52775b807825d1b3b7ca18934c70d88beb1be',
       i686: '9f33a1541717bf823171eef395dd8fe32aacf3804c120591e771c08034ea374a',
     x86_64: '5993b9961a3b8dd1129186aa05370b72c3fd24cd6eaef0b33377a288be713609',
  })

  depends_on 'gtk_doc'
  depends_on 'libexif'
  depends_on 'libusb'

  def self.build
    system 'autoreconf --install --symlink'
    system './configure',
           '--with-camlibs=all,outdated',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
