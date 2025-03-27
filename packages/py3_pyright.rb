require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.398-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e834e38cdced6c3d3cf86455e3e733cb3f191430e172cfa4a50e5f9aac38a36f',
     armv7l: 'e834e38cdced6c3d3cf86455e3e733cb3f191430e172cfa4a50e5f9aac38a36f',
       i686: '9dbfd60419f528a7dc4dae29313a9483e1077da946ae07c7c7b563bb82dc469a',
     x86_64: '68988b79ba8e8f5acf1ffa7f0ee1c0d405ab67c42c81c3880197ac81c3f3c586'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
