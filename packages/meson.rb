require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.55.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.55.0/meson-0.55.0.tar.gz'
  source_sha256 '0a1ae2bfe2ae14ac47593537f93290fb79e9b775c55b4c53c282bc3ca3745b35'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.55.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.55.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.55.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.55.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '16924c076b36276fd5db9af1790b0df4b29133cddb9fe9f6d15fae242cfea033',
     armv7l: '16924c076b36276fd5db9af1790b0df4b29133cddb9fe9f6d15fae242cfea033',
       i686: 'fe38a443f681d0ac1b745c6c49ea685ece608b682b70610ca0ec9743da324c23',
     x86_64: 'c5ea37e4689886212194f5ee880a95aadcc953059961a5a9e88b863ca660ef7f',
  })

  depends_on 'ninja'
  depends_on 'setuptools'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
