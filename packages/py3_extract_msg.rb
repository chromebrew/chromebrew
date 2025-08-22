require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.55.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd69dee983bbc7404e9a08aae85ecd7475daa8c88f64efb0995c0dae8bd2f2426',
     armv7l: 'd69dee983bbc7404e9a08aae85ecd7475daa8c88f64efb0995c0dae8bd2f2426',
       i686: 'fd52cee6a161225f85267f241b6587e39c107cdbfc29ae8bf0524e7d4e2dc163',
     x86_64: '817d06f9eef6bd8ea55bf9ea9916d9cc9490b865eb9d41a6cda86b2150b2fbfd'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
