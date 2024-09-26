require 'buildsystems/autotools'

class Itstool < Autotools
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'https://itstool.org/'
  version "2.0.7-1-#{CREW_PY_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '463e52a82720360bb9a304ff276b81f076ab39c8d1bfb17578123dfb8d897af4',
     armv7l: '463e52a82720360bb9a304ff276b81f076ab39c8d1bfb17578123dfb8d897af4',
       i686: 'b638425cf099a72152bcbaf4c53cd1e6c72d218ddb1eefb4a31aa8d4f67b065c',
     x86_64: '3a33bcc678ab2ce087ae4914997aa577fa93751190cfc64ac95176f2e92f0d6b'
  })

  depends_on 'coreutils' if ARCH == 'i686'
  depends_on 'py3_libxml2'
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build

  def self.patch
    downloader 'https://github.com/itstool/itstool/pull/49.patch', '72dff21156c4fce530cc73862df889c01c79b5b0503d6d38767e1da08b2d4713'
    system 'patch -p1 -i 49.patch'
    downloader 'https://github.com/itstool/itstool/pull/51.patch', '4e64a2e884f9d4cbc493732fcbde9f1d5bed534f9a66330bbcc1cbeb54808c1e'
    system 'patch -p1 -i 51.patch'
    if ARCH == 'i686'
      system "sed -i 's,@PYTHON@,#{CREW_PREFIX}/bin/env -S @PYTHON@,' itstool.in"
    else
      system "sed -i 's,@PYTHON@,/usr/bin/env -S @PYTHON@,' itstool.in"
    end
  end
end
