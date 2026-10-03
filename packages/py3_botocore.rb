require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.108-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3388908760a47d29e78e59bdff726dedc420140cd46c0f39687cb839cc661693',
     armv7l: '3388908760a47d29e78e59bdff726dedc420140cd46c0f39687cb839cc661693',
       i686: '2f19d86f4ae964e5eff0ca75e69ee97021e237edb9749c61f23eacbc233a46b1',
     x86_64: '5e126d8fd0b6bfd07c3026b0152bdd45e869393f76b10fd955ac7b0e3a12e3fe'
  })

  depends_on 'python3' => :logical

  no_source_build
end
