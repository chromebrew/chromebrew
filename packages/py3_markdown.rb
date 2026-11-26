require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.11.4-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '694f687ea40f45b2a3bd717ee4927413ebb97163cacbaaae4a4a8d02572ef844',
     armv7l: '694f687ea40f45b2a3bd717ee4927413ebb97163cacbaaae4a4a8d02572ef844',
       i686: '92a8a5e31ca402cb48891c0c4a0bb90bed9e8b6d8850f1459bfbc1031aa7342e',
     x86_64: '03b43d5517b24c118559b41ef33ea6d56b80dfc514bd32edbf86f91fb9194ebe'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
