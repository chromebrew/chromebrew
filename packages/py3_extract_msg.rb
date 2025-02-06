require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.53.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f210aaf9946fdb05dc39235a54571218f4182b3a2f080f2d79b2d7f802137bd2',
     armv7l: 'f210aaf9946fdb05dc39235a54571218f4182b3a2f080f2d79b2d7f802137bd2',
       i686: '029d9ab5af067c4e516e0c0d6f4136c2b8d9e0a882ec6f23170bb9ec62f5412e',
     x86_64: '725b75e141b23f82ec0819ca75b96ddf1ea02738bc0c72f98448eca51461fe30'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
