require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.54.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f9b59d9388e6742d166bf1dc6cf3f724068110a4e5691d699c2e2e440d76ed0',
     armv7l: '1f9b59d9388e6742d166bf1dc6cf3f724068110a4e5691d699c2e2e440d76ed0',
       i686: '81e0acf7bd3710876fd364dd19d65a26801ccb4fec5cdf86913110bcd07be516',
     x86_64: '9c5ca18c91a051fd4d15be5ceb6091a504b57dd7029fbc4897405ec3e18a7b42'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
