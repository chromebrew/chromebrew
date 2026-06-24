require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.14.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a218abf84cf5dad557877a95a0a4bb6ea6e5a844b8ec024a997faa06224a98ac',
     armv7l: 'a218abf84cf5dad557877a95a0a4bb6ea6e5a844b8ec024a997faa06224a98ac',
       i686: '6d6f5e29138bd1912391de31b0f9aec5a34e4f5c12c715ba7d8317f6d720c09d',
     x86_64: '6e564a7b9206b2dd7c85a393839a6a787aec1f6c399ee43844dc3fef019f6127'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
