require 'buildsystems/pip'

class Py3_secretstorage < Pip
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  version '3.3.3-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89633f6396af8bed04d634b3967de398488cc986a1402a18c4bf71d9cb150d00',
     armv7l: '89633f6396af8bed04d634b3967de398488cc986a1402a18c4bf71d9cb150d00',
       i686: '99703e912c9cd9110f8fb0a96441414740d53fd7ef92af800aa0f6fc70776363',
     x86_64: '3eefe5c7ddbbeab7b05f3d1400ab458ab04e4f366a5275409471f8bf5cc78dc3'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build

  no_source_build
end
