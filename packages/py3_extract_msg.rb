require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.51.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c6f2e63f6512c4ecb5bb5a7ac4072d0a6d0c8fad1237c182456213ab64f0ee3',
     armv7l: '3c6f2e63f6512c4ecb5bb5a7ac4072d0a6d0c8fad1237c182456213ab64f0ee3',
       i686: 'fb0a0c78cfa90789b608d0988ee003abf40eba1f0ee33060fc5a4abd91b93721',
     x86_64: '09ad5bb282abe1286a1edbee36329d55a0d3d772727e897808664fc1307a969b'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
