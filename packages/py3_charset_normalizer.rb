require 'buildsystems/pip'

class Py3_charset_normalizer < Pip
  description 'The Real First Universal Charset Detector. Open, modern and actively maintained alternative to Chardet.'
  homepage 'https://github.com/jawah/charset_normalizer'
  version "3.5.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c6119b20c36f9ef336334f0bd936dafd1a18b218cbd8edec73271c3799bf9927',
     armv7l: 'c6119b20c36f9ef336334f0bd936dafd1a18b218cbd8edec73271c3799bf9927',
       i686: '443ca441204b00910346e56d0fcdb44b3cc01515398756f86d4dc17647e8bef4',
     x86_64: '82265b570b23f7ed628a56927d51fb3eedf31228f63484726a9d1f9b26367585'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
