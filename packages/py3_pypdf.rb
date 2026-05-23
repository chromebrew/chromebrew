require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.12.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78dd32c010ff6aecde7c474f31d4bbf491441bd41b2cc3d6446a548a8963a321',
     armv7l: '78dd32c010ff6aecde7c474f31d4bbf491441bd41b2cc3d6446a548a8963a321',
       i686: '720b09273d9a439fc6af7b07d3c40e69a499faea284e38e1de7e6d029014561f',
     x86_64: '1eaee97564f24d72ef93fb5b70c93788b06b339762e8335c5ca53e1c5e3741d8'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
