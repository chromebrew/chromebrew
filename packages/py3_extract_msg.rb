require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.52.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f210aaf9946fdb05dc39235a54571218f4182b3a2f080f2d79b2d7f802137bd2',
     armv7l: 'f210aaf9946fdb05dc39235a54571218f4182b3a2f080f2d79b2d7f802137bd2',
       i686: '84eb58ef606cc5c95411f8d34532b726b131bbb7cc6b219159f1defe6801845c',
     x86_64: '725b75e141b23f82ec0819ca75b96ddf1ea02738bc0c72f98448eca51461fe30'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
