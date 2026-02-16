require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "1.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41577e91a3b1f05bb3b32b1c5d6cfdcaf8961907e1d61fadb568a1952a56acdf',
     armv7l: '41577e91a3b1f05bb3b32b1c5d6cfdcaf8961907e1d61fadb568a1952a56acdf',
       i686: '3492f061c2e75e04d037c4c36ed9c88a8ab5995bad1aaed3754ecc42f29452c7',
     x86_64: 'bec04a86aa065a87812499554ada90355c66e06fe1f40ee7911f2c5540d47ea9'
  })

  depends_on 'python3' => :build

  no_source_build
end
