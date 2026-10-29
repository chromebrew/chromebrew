require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.21.4-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '920321f277a3514faea58cb44175f0de7ee7df49f326ab013c5f4b7c3dfaac13',
     armv7l: '920321f277a3514faea58cb44175f0de7ee7df49f326ab013c5f4b7c3dfaac13',
       i686: 'e1808959617a3673a98e2c663c4ada9ea2ebf532255b479fa182cf0f2b2084ed',
     x86_64: '0761c52563b47f7d2087221e8c9481cb0e84c8f055defa605f89ef8f8e76ac76'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
