require 'buildsystems/autotools'

class Itstool < Autotools
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  @_ver = '2.0.7'
  version "#{@_ver}-py3.12-1"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22578763153f6008c1dd9e8675825b65a2a0f0b776bcbfb992fe75540e0b3d47',
     armv7l: '22578763153f6008c1dd9e8675825b65a2a0f0b776bcbfb992fe75540e0b3d47',
       i686: '887e17bf8b6bc40df2703cb628d5016e908ac52a41ceb878f17dbb64a245e02c',
     x86_64: '8d02b6b0f963b22a5d7c56ac706c37b39bebecf09687f764da266b764cb8d0a6'
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
