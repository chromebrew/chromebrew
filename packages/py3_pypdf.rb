require 'buildsystems/python'

class Py3_pypdf < Python
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version '4.3.1-py3.12'
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'https://github.com/py-pdf/pypdf.git'
  version '4.3.1-py3.12'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85709a5b4120f13bad22dc682640be06ff26512be3733a965f36757e3a0baa9f',
     armv7l: '85709a5b4120f13bad22dc682640be06ff26512be3733a965f36757e3a0baa9f',
       i686: 'c0aae054b4edf4f2bca39cc6e9087b10a487f3b3f2da43094ae0f52c84c0aec8',
     x86_64: '5afae54f7201699f3af06edadac5576b4eb6a59306aeef144df418acebb4544f'
  })

  depends_on 'python3'
end
