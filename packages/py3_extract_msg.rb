require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.57.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9d5469640ae691a8a18619e41b092afb922c53c78cf841de54a94b5461296ce',
     armv7l: 'b9d5469640ae691a8a18619e41b092afb922c53c78cf841de54a94b5461296ce',
       i686: '0bac4d51d61c002961ae945b00f754e9a17f17fb03a80b410fa177318a97ff96',
     x86_64: '89aadf1e24192bca258b5244708ccc12b4cf5002e92617f21709a129004e58f5'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :logical

  no_source_build
end
