require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.57.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26a5e292ad270e9215c128a6553caa83c23a1ec9ffb3c35c1d2e1131d57fcc5d',
     armv7l: '26a5e292ad270e9215c128a6553caa83c23a1ec9ffb3c35c1d2e1131d57fcc5d',
       i686: '9e35b1af3f51cc4bca787235bd6972442025c1599ee45d082034eb1cb577e036',
     x86_64: '88011d277f418f4025148a29e6053cc1bc7291db5907a9dd83697878d0a4fbe8'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :logical

  no_source_build
end
