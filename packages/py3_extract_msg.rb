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
    aarch64: 'b7ebdcb200fc3a1b85ebd58eefcb0d85f8b67e94c9dfc56728d047fe2ded43c6',
     armv7l: 'b7ebdcb200fc3a1b85ebd58eefcb0d85f8b67e94c9dfc56728d047fe2ded43c6',
       i686: '1f976a462d5220d0063c1de827cf7ad599934c89d14d670604a7ce6226408553',
     x86_64: '868a4089a5cc023a06f2de4104952dd337b0a40fc0c38095485cee43d4d6a8e8'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
