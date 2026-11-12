require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3d427f8b59bdf80843680d860e1af99f06e87e6fbd353144a91fd13cef0a0b2',
     armv7l: 'd3d427f8b59bdf80843680d860e1af99f06e87e6fbd353144a91fd13cef0a0b2',
       i686: 'e62e88054bfaf25122696d181f86eeb9b67172a056fe062201fd5c51c26fd3a7',
     x86_64: 'a3188f39c9df7f2ac9b9290ee4e7dff023d3548ed009835421060d0c21c6bc90'
  })

  depends_on 'python3' => :logical

  no_source_build
end
