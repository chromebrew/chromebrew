require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.82-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '083033df98534ebb9f9509684cc9e6c3a137cb444345a9950e9cb7efe8842041',
     armv7l: '083033df98534ebb9f9509684cc9e6c3a137cb444345a9950e9cb7efe8842041',
       i686: '898631c848e8d371516cbc1db37e80f409909178ea0274e7d93a64717d460d9a',
     x86_64: 'b46ab91910fc257c4bd34984569505849591b7b54835ff2a0712c25ee3608185'
  })

  depends_on 'python3' => :logical

  no_source_build
end
