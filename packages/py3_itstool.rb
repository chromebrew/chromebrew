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
    aarch64: '6d3bfb1577226b6059d7c9c36d4cec050c7faae4af2916445a07c216c5de89f6',
     armv7l: '6d3bfb1577226b6059d7c9c36d4cec050c7faae4af2916445a07c216c5de89f6',
       i686: '230db6a701ebe1a163d8fa0d2f875a988767f789400fa022f68d0a4cdefddce8',
     x86_64: '31331e3deb79ff1aeb4a5925e025fb9611dbc129af42617e5c00cc5345873a74'
  })

  depends_on 'coreutils' if ARCH == 'i686'
  depends_on 'py3_libxml2'
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build

  no_source_build
end
