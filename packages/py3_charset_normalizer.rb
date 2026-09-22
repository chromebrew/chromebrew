require 'buildsystems/pip'

class Py3_charset_normalizer < Pip
  description 'The Real First Universal Charset Detector. Open, modern and actively maintained alternative to Chardet.'
  homepage 'https://github.com/jawah/charset_normalizer'
  version "3.5.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae9a3983292e653db6c202710112ec7ede0ef2b786aae4e298579bff3a49d97a',
     armv7l: 'ae9a3983292e653db6c202710112ec7ede0ef2b786aae4e298579bff3a49d97a',
       i686: '5d1a1a5952d01f79410cfa35e8ee6addcc2e80fc0cc326534b28f05bec6eaa7d',
     x86_64: '37b52db745cb82813f8c146fb66cc8144d084a9eff944a3be6650772b8a853b8'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
