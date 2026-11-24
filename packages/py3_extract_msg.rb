require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.58.3-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '153a9a05be2e808d8b2db00a2299c1286d273c15afb6734daca06808b7097e88',
     armv7l: '153a9a05be2e808d8b2db00a2299c1286d273c15afb6734daca06808b7097e88',
       i686: 'bd7290b711d07d09ebf0237f89d8f118fec33e48ee0717222ff71e052bd4782e',
     x86_64: '1c7db84a65617805b9b09539b7c19685f390a673033ee2e591775795c8d067c4'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :logical

  no_source_build
end
