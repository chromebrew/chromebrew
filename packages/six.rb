require 'package'

class Six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://github.com/benjaminp/six'
  version '1.11.0'
  source_url 'https://github.com/benjaminp/six/archive/1.11.0.tar.gz'
  source_sha256 '927dc6fcfccd4e32e1ce161a20bf8cda39d8c9d5f7a845774486907178f69bd4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.11.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a0568eddd9cbbb946995f7cdec51af27a20b4c7a8a8acfc858f914670127f49b',
     armv7l: 'a0568eddd9cbbb946995f7cdec51af27a20b4c7a8a8acfc858f914670127f49b',
       i686: '08e6dc17e7e38f5ebe1a232da19fb705d086506cda13568cbe98c0329b7dab60',
     x86_64: 'fda02acf7263f566fb43018402175064ebff70be2b1c486151a408be8c3c5110',
  })

  depends_on 'python3'
  depends_on 'python27'

  def self.build
    system "python2.7 setup.py build"
    system "python3 setup.py build"
  end

  def self.install
    system "python2.7 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
