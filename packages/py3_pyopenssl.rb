require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version '24.2.1-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a38123ee16686fcb9029c3d3fce06fe8fb85973424addd0d559fe9d2975dee51',
     armv7l: 'a38123ee16686fcb9029c3d3fce06fe8fb85973424addd0d559fe9d2975dee51',
       i686: '4e32faaade1d77148402696e2dc7faded8b8c28044f36a1425d4e109ac9afc07',
     x86_64: '0b9bfa34bf7a9e6d70287b4822055b9043520e2c655f331351555a93b3ff7348'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
