require 'buildsystems/pip'

class Py3_charset_normalizer < Pip
  description 'The Real First Universal Charset Detector. Open, modern and actively maintained alternative to Chardet.'
  homepage 'https://github.com/jawah/charset_normalizer'
  version "3.4.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc3ca1c8cd9d147f11c97238b31ac88454bd3529d666ddb17d53ce5a38b9ddbd',
     armv7l: 'cc3ca1c8cd9d147f11c97238b31ac88454bd3529d666ddb17d53ce5a38b9ddbd',
       i686: 'a03c77ce8141561a038e5a79c6d4463064b79f81e7ab6d1a5584cd42fb533d00',
     x86_64: '2d3d8004f1383bcf2cd17a91fe76b7f2df51886447818ba9112cf7e8412510ac'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
