require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.16-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eccbedf4f5ced9761384170ec4b1cca39460c64d743bda3f6d32bf8fff749bda',
     armv7l: 'eccbedf4f5ced9761384170ec4b1cca39460c64d743bda3f6d32bf8fff749bda',
       i686: '9230c75dd320f6a6681a0596c26caee73d77c88004a6cb61cac249b7494661d1',
     x86_64: 'bf5e3f83aac32a4ef03d1329ce18733957110fc0deb4c64b9b5a80db207d52d9'
  })

  depends_on 'python3' => :logical

  no_source_build
end
