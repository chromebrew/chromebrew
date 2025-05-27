require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "3.22.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e712d37ef2c23bf171f83528da45ceabdbf0b5fd751b70fe3922a2b244a40f9',
     armv7l: '1e712d37ef2c23bf171f83528da45ceabdbf0b5fd751b70fe3922a2b244a40f9',
       i686: '3bece534a32b4e7215740bf49e3f5874344d5c7bf8892ab689c5b09fe83dafc6',
     x86_64: '47f344571ae35148f40cf54967ec33bbf933aa84ed49dda2f4fced1cb412688d'
  })

  depends_on 'python3' => :build

  no_source_build
end
