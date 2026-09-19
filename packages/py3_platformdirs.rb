require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac853ec41df08a56711a325c87dd64c3fa21d0a79de6e9b7e18a2ac60e26f2d5',
     armv7l: 'ac853ec41df08a56711a325c87dd64c3fa21d0a79de6e9b7e18a2ac60e26f2d5',
       i686: 'e640b524a90801c65f590d604379c896059834c05483d9325e93f9efb754c466',
     x86_64: '7b99c47be3c52f24faca81d0e3600f1b3fbf9e405f1cd6d5feda7db0de8456b0'
  })

  depends_on 'python3' => :logical

  no_source_build
end
