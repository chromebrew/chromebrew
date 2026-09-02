require 'buildsystems/pip'

class Py3_streamlit < Pip
  description 'A faster way to build and share data apps'
  homepage 'https://streamlit.io/'
  version "1.63.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b8703154a5f4d611c4088b137b781788c836de5092ec2620b515bfdc9efdfc5',
     armv7l: '6b8703154a5f4d611c4088b137b781788c836de5092ec2620b515bfdc9efdfc5',
       i686: '017000405cf9b32532057bbc4cfcc1b9d2fb37d1dbbfb10a177470ecb998821c',
     x86_64: '057b8640cb917d633aa327a46542bb659044a902e1267bf34dd0e2c8da68bb96'
  })

  depends_on 'python3' => :logical

  no_source_build
end
