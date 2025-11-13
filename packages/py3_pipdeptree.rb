require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.30.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c30c3e994b7563cc1cf9d51467adcee4e7bc38223e4301ace84076d70a18daa',
     armv7l: '3c30c3e994b7563cc1cf9d51467adcee4e7bc38223e4301ace84076d70a18daa',
       i686: '4329667e50f7692d859bc7e549209f5e0edd4cb4c747cdc6952ae9ad951ebe37',
     x86_64: '86d33ef521c159b1db545851c169317492bffdea0e3025378aa55e767740e4fd'
  })

  depends_on 'python3' => :build

  no_source_build
end
