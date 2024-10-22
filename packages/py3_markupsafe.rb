require 'buildsystems/pip'

class Py3_markupsafe < Pip
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  version "3.0.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ac52d175f30d1c71cbe716666db37b38bda1aab902b4711fc65b0b4787e6e85',
     armv7l: '6ac52d175f30d1c71cbe716666db37b38bda1aab902b4711fc65b0b4787e6e85',
       i686: '3c7918bacfe87950e96e6c61bd7c01cba0e9eb001a2c8c5fa00044cb84b3d036',
     x86_64: '49f99e35b905332c91f943412514275618af337f5b70ea89cc35246d2c3b53fd'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
