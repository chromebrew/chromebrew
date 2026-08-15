require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "7.6.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e2a11cab1fcfe98dd19490679f801cdd16c67013c032aa54b3b3f0032b2aceb',
     armv7l: '0e2a11cab1fcfe98dd19490679f801cdd16c67013c032aa54b3b3f0032b2aceb',
       i686: 'b0d38b94d9bcd19dd6faa1de7e0cb48eeaada79848c784a58209c6ca56406687',
     x86_64: '43362170a0849e792572e535c84d3e03d7850a1b1845218db662ff6ba632f59f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
