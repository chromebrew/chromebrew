require 'buildsystems/pip'

class Py3_patchelf < Pip
  description 'Patchelf is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://pypi.org/project/patchelf'
  version "0.17.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '439ce6c90d77ab4c18ff2176ef8e4e9c64cf3d23a4b8a7368e5cb1db83025b9b',
     armv7l: '439ce6c90d77ab4c18ff2176ef8e4e9c64cf3d23a4b8a7368e5cb1db83025b9b',
       i686: 'a1134600b06e06fd0b88f02ff3e09c862a1ae3e2b89aa4cbcd4a8417ebcb7b8f',
     x86_64: '3b84047e17dcb794ce5cd247de73169290eb2d7127734ae6e288c5606e9f65da'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # Conflicts with patchelf.
  no_source_build
end
