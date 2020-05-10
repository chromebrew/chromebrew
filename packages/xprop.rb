require 'package'

class Xprop < Package
  description 'Xprop is a property displayer for X.'
  homepage 'https://www.x.org/'
  version '1.2.3'
  compatibility 'all'
  source_url 'https://x.org/releases/individual/app/xprop-1.2.3.tar.bz2'
  source_sha256 'd22afb28c86d85fff10a50156a7d0fa930c80ae865d70b26d805fd28a17a521b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xprop-1.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xprop-1.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xprop-1.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xprop-1.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '12aec4691f07cb0d55bd31441b02a5d496c15c7ffccce46866506669833de899',
     armv7l: '12aec4691f07cb0d55bd31441b02a5d496c15c7ffccce46866506669833de899',
       i686: '40d86af58fce14adf2bf12605a7935345c759a03513d590e63b50c5198d60b95',
     x86_64: 'aaeb4ab85d29869250c52958035df3e0317d168f42ce3577b5edee1a2c9aa484',
  })

  depends_on 'xorg_lib'

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
