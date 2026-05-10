require 'buildsystems/pip'

class Py3_pydf < Pip
  description 'Displays the amount of disk space available on the mounted filesystems, using different colours for different types of filesystems.'
  homepage 'https://github.com/garabik/pydf'
  version "12-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea6602b6a7de2845be627f377c33ea003269c2176bceb8416c32d5db426dcb87',
     armv7l: 'ea6602b6a7de2845be627f377c33ea003269c2176bceb8416c32d5db426dcb87',
       i686: 'c3fae35e95b02b3ea194569048cfb00c9c963bd8d938d4532eb06663ffcb906c',
     x86_64: '83efb645f2c2ebc7d00286db742d2587d5b146a8b7c767807ab089f39757bec5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
