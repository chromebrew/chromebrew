require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.44.0-1'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.44.0/meson-0.44.0.tar.gz'
  source_sha256 '50f9b12b77272ef6ab064d26b7e06667f07fa9f931e6a20942bba2216ba4281b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.44.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.44.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.44.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.44.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0fd514b6ea8d80a48a3e374175e1624a465b699d1b0bb9b15c447b49397b7d38',
     armv7l: '0fd514b6ea8d80a48a3e374175e1624a465b699d1b0bb9b15c447b49397b7d38',
       i686: '39995c658f15fa4b8d432a8f3a66e660d5fdebbf964262fa07c5b4cd182f2709',
     x86_64: '19c473a9f38e549ba03cde3208da6e39f09ffa381be5ff32db9acc8e30e7c6b4',
  })
  
  depends_on 'ninja'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
