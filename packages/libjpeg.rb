require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'https://www.ijg.org/'
  version '9.4.0'
  license 'custom' # Very similar to the BSD license
  compatibility 'all'
  source_url 'https://www.ijg.org/files/jpegsrc.v9d.tar.gz'
  source_sha256 '6c434a3be59f8f62425b2e3c077e785c9ce30ee5874ea1c270e843f273ba71ee'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/9.4.0_armv7l/libjpeg-9.4.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/9.4.0_armv7l/libjpeg-9.4.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/9.4.0_i686/libjpeg-9.4.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/9.4.0_x86_64/libjpeg-9.4.0-chromeos-x86_64.tpxz',
  })
  binary_sha256({
    aarch64: '5aea50db0ee0ad0839f58b973cff9808b57babba318409a36b7967b1c4f8285f',
     armv7l: '5aea50db0ee0ad0839f58b973cff9808b57babba318409a36b7967b1c4f8285f',
       i686: '041768d7dcbe7720371629f8d5e1eafdf18a14bd69b1d06eefff5cc36f42f2c3',
     x86_64: '74ae5e410b0407999b85c0837c56d6e265c4dfb4098bc6413e6438b60bb89524',
  })

  def self.build
    system '[ -x configure ] || ./bootstrap.py'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir CREW_DEST_LIB_PREFIX do
      FileUtils.ln_s 'libjpeg.so.9.4.0', 'libjpeg.so.8'
    end
  end
end
