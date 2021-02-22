require 'package'

class Nuitka < Package
  description 'nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version '0.6.10.5'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka/archive/0.6.10.5.tar.gz'
  source_sha256 'e29f150b308d2c388c4faa2b14bf4e2ea5259b3ba996e50a7dbc9ceb0f97cae4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nuitka-0.6.10.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nuitka-0.6.10.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nuitka-0.6.10.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nuitka-0.6.10.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aa4bdd67d05ccaa1120f282e561a3cd243d88f31832fad68cfeaa1dcd329ad5e',
     armv7l: 'aa4bdd67d05ccaa1120f282e561a3cd243d88f31832fad68cfeaa1dcd329ad5e',
       i686: '2f766be192c5189f1f984d14defe4c071f81d2da5d2a132c964dbc774fa62e5d',
     x86_64: 'b205b85b35b1668aca5d2c5c725a5d3c2b684c2bf46c75bcef640d522babe614',
  })

  def self.install
    system "python3 -m pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I nuitka==#{version} --no-warn-script-location"
  end
end
