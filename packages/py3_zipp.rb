require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "4.1.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '07ab1a2efe2f9c4ee67cb2e71c8be66d8e92cf03cf50ba5f13c010637851bb1f',
     armv7l: '07ab1a2efe2f9c4ee67cb2e71c8be66d8e92cf03cf50ba5f13c010637851bb1f',
       i686: '26c35e80f9becd9e40593961e33853c1f8bfa9be0556db435003d37058d28b59',
     x86_64: '67ca6f9a9a175be19e9fbc3f2bbc90b73bf40e390ba7a747efff42e0a08682b4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
