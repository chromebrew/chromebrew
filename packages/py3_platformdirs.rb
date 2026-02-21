require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.9.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3bdcb14aac8f52c6049af69ec3c27ad017c5fa626231c48cca3116a70059c5e7',
     armv7l: '3bdcb14aac8f52c6049af69ec3c27ad017c5fa626231c48cca3116a70059c5e7',
       i686: '32308b7ff404590cc18862a3d1e4c23b7613badb551caf7320d73dd84547213b',
     x86_64: '147eed4b410127a0a89a1085633bcf13a10b7d16f7383eaf4bbb7b2a0ef7aaa0'
  })

  depends_on 'python3' => :build

  no_source_build
end
