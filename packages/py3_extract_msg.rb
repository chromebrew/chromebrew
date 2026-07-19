require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.56.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca34265f5180754334f77e93adfc9412e7040847ce7f30f4c0bc24055144eabe',
     armv7l: 'ca34265f5180754334f77e93adfc9412e7040847ce7f30f4c0bc24055144eabe',
       i686: 'd5da481e8d74fec8e892d80127dab8a3295ccbcd151504b5fa7d7494b6e1ae2a',
     x86_64: 'd0e588f902d33b441c8f27e6e272b983f8fb903533a0ff17fb3b17c2c06a2ac8'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :logical

  no_source_build
end
