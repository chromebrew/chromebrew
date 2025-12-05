require 'buildsystems/pip'

class Py3_itstool < Pip
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'https://itstool.org/'
  version "2.0.7-#{CREW_PY_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd009a0414b16e306bd53e12edd4924c9a07200e4136b5209ce23c4558f8aa7a5',
     armv7l: 'd009a0414b16e306bd53e12edd4924c9a07200e4136b5209ce23c4558f8aa7a5',
       i686: '9730d43c2aeaa6c103e3bc8e43fc2943edee9b92f04f9a7a63d7def1a2838787',
     x86_64: '000d264ed866829beb57e73b2f46af87b75e8927ed95df99793cc755025d5243'
  })

  depends_on 'coreutils' if ARCH == 'i686'
  depends_on 'py3_libxml2'
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build

  no_source_build
end
