require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.48.2'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.48.2/meson-0.48.2.tar.gz'
  source_sha256 '39ead8bfd0dc9c7b0af15e23ea975c864600bf871fba279c9918625bb9a85506'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.48.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.48.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.48.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.48.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9a5f1420003ee72848c76d9c9a53bbce10a30484e48e7a76a88d224fe3d6a81f',
     armv7l: '9a5f1420003ee72848c76d9c9a53bbce10a30484e48e7a76a88d224fe3d6a81f',
       i686: 'f875c2151456f44b7b2ada00e3e09676ce3457f3234c8b5f0b956a62222720cb',
     x86_64: '96406f75738f1ae81fb382016988b577f6e3c610bfd7bde48b60033333b44e3a',
  })

  depends_on 'ninja'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
