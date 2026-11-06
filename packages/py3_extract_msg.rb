require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.58.2-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3364c52e423ebbd7193a4fc024ed1a71dae9989ef63637d8808726b452575a69',
     armv7l: '3364c52e423ebbd7193a4fc024ed1a71dae9989ef63637d8808726b452575a69',
       i686: 'cb5b63ee0408548d09212e8e173faba2ccf082c2e4543f399abfd0c27fea4267',
     x86_64: '3aa08618877f5213ab7753028b2751cdd2e440440171bb0b34f9a15c03b4013a'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :logical

  no_source_build
end
