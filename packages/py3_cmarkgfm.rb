require 'buildsystems/pip'

class Py3_cmarkgfm < Pip
  description 'Python bindings to GitHub\'s cmark.'
  homepage 'https://github.com/theacodes/cmarkgfm'
  version "2024.11.20-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0277c9efd8fc5ad8e0d0a075e5356f3a9f13ebe92b58487789ae06b0187be0f3',
     armv7l: '0277c9efd8fc5ad8e0d0a075e5356f3a9f13ebe92b58487789ae06b0187be0f3',
       i686: 'd60b44e2366c538cae7bdddd583910f8a323ff021a56e6b442c556da7057d9b6',
     x86_64: 'fc7a97d99f9d2159bc40117a76bac6ea8ad81027310fcb4e413b5a19ac112bb9'
  })

  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' => :build

  no_source_build
end
