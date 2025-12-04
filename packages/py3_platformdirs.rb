require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb2e5f6c5acdc04be3fa1b4542cc6381329a20e8b69f7569a248242d23e0fed0',
     armv7l: 'cb2e5f6c5acdc04be3fa1b4542cc6381329a20e8b69f7569a248242d23e0fed0',
       i686: 'cb92d6c3f4c9afa73c51638b5ae530746e338ea49761311881734ce1a4b249d0',
     x86_64: 'd6c9c93fc97b045a6ada7a4167d72078d6493968be67950918e095286acee37a'
  })

  depends_on 'python3' => :build

  no_source_build
end
