require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'https://www.ijg.org/'
  version '9.0-d-1'
  license 'custom' # Very similar to the BSD license
  compatibility 'all'
  source_url 'https://www.ijg.org/files/jpegsrc.v9d.tar.gz'
  source_sha256 '6c434a3be59f8f62425b2e3c077e785c9ce30ee5874ea1c270e843f273ba71ee'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libjpeg-9.0-d-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libjpeg-9.0-d-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/libjpeg-9.0-d-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/libjpeg-9.0-d-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2907c8f5bf31c2242647eb42838ab60c3ffada2d8c34fa9a71c5939f8538108a',
     armv7l: '2907c8f5bf31c2242647eb42838ab60c3ffada2d8c34fa9a71c5939f8538108a',
       i686: '9c56d093f018a496edb8db4a797b3aa54cbe1fb86692dc6d942aa605e699bc5c',
     x86_64: 'a21d5cc6bba91a06584ad2d4646a0aa96ef5b50ab33ed888f02513946c8e143f'
  })

  def self.build
    system '[ -x configure ] || ./bootstrap.py'
    system "env CFLAGS='-flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
