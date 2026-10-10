require 'buildsystems/pip'

class Py3_charset_normalizer < Pip
  description 'The Real First Universal Charset Detector. Open, modern and actively maintained alternative to Chardet.'
  homepage 'https://github.com/jawah/charset_normalizer'
  version "3.5.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a2a73444d550d625aa211efeb709ae771497611e0d5df04c72b4c195d42705a',
     armv7l: '7a2a73444d550d625aa211efeb709ae771497611e0d5df04c72b4c195d42705a',
       i686: '6e570664dfd450ab9be630f926ce52475a78b4609b6ecdfd6015e66f1d5a7d13',
     x86_64: '4ba56d188da039d213635c8510426dabce08522332d90d140ba363a277c3b7ca'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
