require 'package'

class Libotf < Package
  description 'OpenType Font library'
  homepage 'https://www.nongnu.org/m17n/'
  @_ver = '0.9.16'
  version @_ver
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/m17n/libotf-#{@_ver}.tar.gz'
  source_sha256 '68db0ca3cda2d46a663a92ec26e6eb5adc392ea5191bcda74268f0aefa78066b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libotf-0.9.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libotf-0.9.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libotf-0.9.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libotf-0.9.16-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '48ea420876299f2de783c250b6def3c2a87e7bf8c16695a63b7561efbb9594f8',
     armv7l: '48ea420876299f2de783c250b6def3c2a87e7bf8c16695a63b7561efbb9594f8',
       i686: '487c98f04bdc12c06a2afd32087222150ee652d9fc3c6233daee341c41718406',
     x86_64: '8ec1c9f4e8b99482323e3bf444cca95b5e3d0abb90b8ea278d1461b29470e340'
  })

  depends_on 'libxaw'
  depends_on 'freetype'
  depends_on 'hashpipe'

  def self.patch
    system 'curl -Ls https://github.com/archlinux/svntogit-packages/raw/a67b940a19f1e7e47e7d8553ed31158ed70f1286/libotf/trunk/replace-freetype-config.patch | hashpipe sha256 edd0f86332f4d809dfb0ab66da547c946e5d79a907a7eaddc4d2166c78205668 | patch -p1 -b'
  end

  def self.build
    system 'autoreconf -i'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
