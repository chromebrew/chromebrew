require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.53.0'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.53.0/meson-0.53.0.tar.gz'
  source_sha256 '035e75993ab6fa6c9ebf902b835c64cf397a763eb8e65c9bb6e1cc9730a9d3f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.53.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.53.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.53.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.53.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cce1f631fe48be9a287ffdfe18fb0c841e880af98d5c486c07dee5dbf4722182',
     armv7l: 'cce1f631fe48be9a287ffdfe18fb0c841e880af98d5c486c07dee5dbf4722182',
       i686: '5dad566b1bd6d142c78b53cecf4c06068c2b6c0a1901ec7aeb6bff55b11a84e4',
     x86_64: '5246ffe7d4b2b2901a2c9dd21c6516634314d247c8a2dc09d3a0a3c516485923',
  })

  depends_on 'ninja'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
