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
       i686: '1f976a462d5220d0063c1de827cf7ad599934c89d14d670604a7ce6226408553',
     x86_64: '868a4089a5cc023a06f2de4104952dd337b0a40fc0c38095485cee43d4d6a8e8'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
