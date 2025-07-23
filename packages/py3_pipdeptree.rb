require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.28.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b59a547b7954ac828c9d455bb162734f8d1999827a2d140976d0f2d868a0b58',
     armv7l: '2b59a547b7954ac828c9d455bb162734f8d1999827a2d140976d0f2d868a0b58',
       i686: '70d8d96979dd3d0e317dd14c4e56795ff7d6b235284236636d65e70b078f9639',
     x86_64: '70d8d96979dd3d0e317dd14c4e56795ff7d6b235284236636d65e70b078f9639'
  })

  depends_on 'python3' => :build

  no_source_build
end
