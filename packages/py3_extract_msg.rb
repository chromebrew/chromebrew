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
    aarch64: 'd62f2b1a306493eb8a182b8b48a1b9e74b40e6b4679285fb081427f9992d9673',
     armv7l: 'd62f2b1a306493eb8a182b8b48a1b9e74b40e6b4679285fb081427f9992d9673',
       i686: '981f3ac82e4e35505d838748eb04da713c02f775a1feecb2d71bdf6b8138b411',
     x86_64: '2ecc649a1a2f6cf23bc14e3d1b66445c0470916d08614b038834c45ee99e35e0'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
