require 'package'

class Six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://github.com/benjaminp/six'
  version '1.12.0'
  source_url 'https://github.com/benjaminp/six/archive/1.12.0.tar.gz'
  source_sha256 '0ce7aef70d066b8dda6425c670d00c25579c3daad8108b3e3d41bef26003c852'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ba69ece2f777f5c2d7446f8f40c075e03ec4cfde838bd88cb7a7af5ecc77102e',
     armv7l: 'ba69ece2f777f5c2d7446f8f40c075e03ec4cfde838bd88cb7a7af5ecc77102e',
       i686: '7bc2e16af9e81fe89fda678fd770808fcd022f62dc9719a515b6dfaa54d93f55',
     x86_64: '206dea928935e759ef3f37193595b32e1e2eef16f4be877ec41fe50cb6c67d2a',
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
