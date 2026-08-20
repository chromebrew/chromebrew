require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.56.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85136295e6c291dc0d44bf8fca9a2bc96844a1db05c766e2abc6e3ed027b32ed',
     armv7l: '85136295e6c291dc0d44bf8fca9a2bc96844a1db05c766e2abc6e3ed027b32ed',
       i686: '9de49e36fa551b72ec4acb9607017610be056aa870d02ef8d46f1e96074df53b',
     x86_64: '185fbdffc57c15bc8972d54eb6aae8a7411be13492adec9bd4b1f068780c8872'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :logical

  no_source_build
end
