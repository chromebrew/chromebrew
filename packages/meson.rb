require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.52.0'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.52.0/meson-0.52.0.tar.gz'
  source_sha256 'd60f75f0dedcc4fd249dbc7519d6f3ce6df490033d276ef1cf27453ef4938d32'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.52.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.52.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.52.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.52.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '92400a58c43f1d1c729fea0b548bea093a439110729b7dabf7fe56c6b816d721',
     armv7l: '92400a58c43f1d1c729fea0b548bea093a439110729b7dabf7fe56c6b816d721',
       i686: 'a83a4e4b1a2b516141e5fe744e9b4f57ec823dd9561e2ff22e558015adc4e3d3',
     x86_64: '504f7a9829eb50e497c4aba9b2115909144b4e36909e3648453ad96686cce60d',
  })

  depends_on 'ninja'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
