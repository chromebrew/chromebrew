require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.20.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f1aac5f804a84cd25d780b5ff39d37e8cfda67e66e3f717e4e144b5e7c7f14b',
     armv7l: '1f1aac5f804a84cd25d780b5ff39d37e8cfda67e66e3f717e4e144b5e7c7f14b',
       i686: '3885b23774398d96532715b3fbed26e21a878352fd4926ea33c5cb5f0808af5f',
     x86_64: '60db960572db6d927edf3a36225cd9e43f8bb89d4c79dacf54ea099d278747cd'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
