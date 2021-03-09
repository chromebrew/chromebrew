require 'package'

class Nuitka < Package
  description 'nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version '0.6.12.3'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka/archive/0.6.12.3.tar.gz'
  source_sha256 '4f65349b87c3ffc297e19251308d743ee8b5ef09b695c134d6a46ec89d255216'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nuitka-0.6.12.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nuitka-0.6.12.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nuitka-0.6.12.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nuitka-0.6.12.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34b1e243d748254248e460992194b40cc79813cb9d59bf01a1c940e2c3519725',
     armv7l: '34b1e243d748254248e460992194b40cc79813cb9d59bf01a1c940e2c3519725',
       i686: '96be8a2d57245d5f9414bd13242f3e6ae5ab5927a8455afbddd43d27a45b83ce',
     x86_64: '5ef1b47e0ec8a22c3852c1ba7b11efc5034558db2ef231f2e23bbe7628b558d9',
  })

  def self.install
    system "python3 -m pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I nuitka==#{version} --no-warn-script-location"
  end
end
