require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2024.9.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3fa8f447d1fe538a243392aa74e2fe7fae380155e955c92a58b7171559f2974',
     armv7l: 'f3fa8f447d1fe538a243392aa74e2fe7fae380155e955c92a58b7171559f2974',
       i686: 'ef00dd7bbd069dcb5df97821c4f1ac839df67644f722a86205052623920f5a1c',
     x86_64: 'e0c9b2c6bbbc7fea59d3e83b1af5d71e245d487b9680c87ffe357210775b9641'
  })

  depends_on 'python3' => :build

  no_source_build
end
