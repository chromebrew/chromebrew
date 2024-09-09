require 'buildsystems/pip'

class Py3_libevdev < Pip
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  version '0.11-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '470df0ac923fa97e48c1f093c2aeaf3aac580e609d81efb8fdf24392940e04c3',
     armv7l: '470df0ac923fa97e48c1f093c2aeaf3aac580e609d81efb8fdf24392940e04c3',
       i686: '4fdd75f9fb347dd62af96879dded6e49a4329880a922684ae388981efacf60d0',
     x86_64: '46ee7235b348f7d168ad7f521b7211e1d33c4a778d642336cd5977fc17d69cd2'
  })

  depends_on 'python3' => :build

  no_source_build
end
