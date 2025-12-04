require 'buildsystems/pip'

class Py3_abimap < Pip
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  version "0.4.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90403f60545cd79ac583afa0cd242b4f0a336a9ed6457bf058a0cddcbfb151c1',
     armv7l: '90403f60545cd79ac583afa0cd242b4f0a336a9ed6457bf058a0cddcbfb151c1',
       i686: 'daf6c55138d500e6f1b3e5a68ff9e2f654bb18257e0e69414a41d8752dd76216',
     x86_64: 'bd21b3a690d51789bbe4e02e47201a7d6ca3ec9e2a68f0e69d1aa0c27e926eb0'
  })

  depends_on 'python3' => :build

  no_source_build
end
