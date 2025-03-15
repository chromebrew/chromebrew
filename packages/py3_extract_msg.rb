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
       i686: 'f0f8a73f040c1ce025bae6b8c25328401d5922fcae7ebf8d5f6e2cdc092278f9',
     x86_64: '9c5ca18c91a051fd4d15be5ceb6091a504b57dd7029fbc4897405ec3e18a7b42'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
