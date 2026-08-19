require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.74-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57069658d60abb67a1a3576bd2bee4e1b89d898d282309f427bf3b3ffc0b1ec0',
     armv7l: '57069658d60abb67a1a3576bd2bee4e1b89d898d282309f427bf3b3ffc0b1ec0',
       i686: '948914dddf036e165860684c2f1fab19b5fda1bf557c26204a841e7da1993cbd',
     x86_64: 'af94ed7ce786e3ec0df4182df208c758413ad94e97226ac1498c5980d3f6ad1e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
