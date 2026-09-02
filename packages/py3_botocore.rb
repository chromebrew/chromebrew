require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.86-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26be1976dce25eb63771a6895205246dae345891003dfeabda985797915f2bfd',
     armv7l: '26be1976dce25eb63771a6895205246dae345891003dfeabda985797915f2bfd',
       i686: '67744dd25a132f7c4aaa5062282920b4f438fc07db6897dfd9b0c46f43c3efd7',
     x86_64: 'd6f434a0aa8373c14405b98d17ea48998b7b17955450af5b8f5ac3027427c332'
  })

  depends_on 'python3' => :logical

  no_source_build
end
