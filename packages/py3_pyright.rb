require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.405-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64ff937288498764a78b3f9e7a7a97b791a974db6791253fca0ee55c8dc9ccce',
     armv7l: '64ff937288498764a78b3f9e7a7a97b791a974db6791253fca0ee55c8dc9ccce',
       i686: '2b3c907ea611c98f7aaa52477c617a47d1cd52449145974ff7d6a90e6509ee16',
     x86_64: '95e10a9a0cf8a1e1a178e9809737a000670958fd56b5b5636804da4db373b376'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
