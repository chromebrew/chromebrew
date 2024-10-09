require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.50.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0e152eb9539a5d8abbd27e87aeb73d379dcabde4d29d70cd473c51179bd60ef',
     armv7l: 'd0e152eb9539a5d8abbd27e87aeb73d379dcabde4d29d70cd473c51179bd60ef',
       i686: '57f17d2a73b45b3540e86c3430ad96b2a7b60f5ef4e72337cadeab93d9b84f12',
     x86_64: 'fad8ebdd11981999aecaafbf64516f5c7a0aa8f819e41f7d43fdce0574a5d967'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
