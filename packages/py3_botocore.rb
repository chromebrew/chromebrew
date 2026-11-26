require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.12-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f6cbdf6a42a985b476b374288c24368866ea2e993e51eac2641771d3582d08d',
     armv7l: '9f6cbdf6a42a985b476b374288c24368866ea2e993e51eac2641771d3582d08d',
       i686: '6c4916f27f9128f9fe329664c785be693e118a5b7dfd15a33fea3bb0e3e38e6f',
     x86_64: '491e8971c9f993723344e6ed41bed1072614d7f9d9c83a6eb91b67b9e6c17d7f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
