require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8ea33d95a72b776cff7f4f56dbad62c72e25fcfd94b46a9de653f345dad2056',
     armv7l: 'd8ea33d95a72b776cff7f4f56dbad62c72e25fcfd94b46a9de653f345dad2056',
       i686: 'f9f8e3460bbb6d403e3c0ba49d1ebe0e356869be1d1f81e84e3834ee8322ff07',
     x86_64: 'fbad3a87d17996152e89a681077756ca141ac5ae3c64b7a8b300f782dc4ba934'
  })

  depends_on 'python3' => :logical

  no_source_build
end
