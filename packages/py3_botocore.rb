require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.125-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c560e70cd1793bca7e251b339cd2662159dc87b27e74c5c28e09dc23f35873de',
     armv7l: 'c560e70cd1793bca7e251b339cd2662159dc87b27e74c5c28e09dc23f35873de',
       i686: 'b2af27b203fd3683b4cacc92501150dc042bc2263dc22a84ddd631f39a75dac3',
     x86_64: '6e14d049e0a634f4407a889d37642ff604a6c75442e03201cce1bbfc5701472e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
