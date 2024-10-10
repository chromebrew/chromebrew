require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "5.2.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce99acaf4810a9f7ed18c5021f28b54266a19bc1db9c633d4def82eeade9bc9d',
     armv7l: 'ce99acaf4810a9f7ed18c5021f28b54266a19bc1db9c633d4def82eeade9bc9d',
       i686: '651212d3e187c15932f81c146bff4fd82bd0fab86e036b1c8d72be6d43642b24',
     x86_64: '805ac37a74b0334e8d2163c45682c4ad8b7227cec14dde551a0c8bac981a64bf'
  })

  depends_on 'python3' => :build

  no_source_build
end
