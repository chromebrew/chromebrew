require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.53.2-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e861621994ce684bf759bd8b0f689ce7ede5d2c76a66042ca0e3a1ff1fbd0f0a',
     armv7l: 'e861621994ce684bf759bd8b0f689ce7ede5d2c76a66042ca0e3a1ff1fbd0f0a',
       i686: '029d9ab5af067c4e516e0c0d6f4136c2b8d9e0a882ec6f23170bb9ec62f5412e',
     x86_64: 'c236ea48853f3aedf4e9e43c023580836a4c3b6be599f2b4e8dd833e9c999196'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
