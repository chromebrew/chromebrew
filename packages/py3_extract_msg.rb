require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.58.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1d04ee00d77cb5164e987be21eef94519bcf7efb008fa6f5d1aee4ec20403cd',
     armv7l: 'a1d04ee00d77cb5164e987be21eef94519bcf7efb008fa6f5d1aee4ec20403cd',
       i686: '17cf4ac3b56dc4382bce662d8eae8ce434275e9765ff4ebf56b5155d6147c2e9',
     x86_64: 'd0013ae33170b522799812bbc3a868a3bb381e8adbd4a19a70288ba8495d0338'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :logical

  no_source_build
end
