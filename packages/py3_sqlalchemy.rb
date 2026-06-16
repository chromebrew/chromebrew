require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.51-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fa8b52c0ab4ced9a17d04ef324f16414e5f2a05c9218a30c71250a941143f15',
     armv7l: '3fa8b52c0ab4ced9a17d04ef324f16414e5f2a05c9218a30c71250a941143f15',
       i686: 'fc2da3270fef599aeb717e703b3d3be51deb6b4edb9838d6212921c39cd1d79d',
     x86_64: 'd4bc2a8a9553e883edcd731af3e0aaf4fc3db9e7056b7d68f2a76d1ace25102f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
