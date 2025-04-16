require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.54.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4c9c8e3448b922a72f53382452c7374b4605cace15ad13be32c6be639677b38',
     armv7l: 'd4c9c8e3448b922a72f53382452c7374b4605cace15ad13be32c6be639677b38',
       i686: '81e0acf7bd3710876fd364dd19d65a26801ccb4fec5cdf86913110bcd07be516',
     x86_64: 'cd4a5f29e142f4a6c417784029288234b1e4415db6e817f2589612c7a6f83781'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
