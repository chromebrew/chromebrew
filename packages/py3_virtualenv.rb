require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.2.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01fec0ab6d8a8d0b1ed17bbddd12094db1211a77023e4103260e6e08219a4c01',
     armv7l: '01fec0ab6d8a8d0b1ed17bbddd12094db1211a77023e4103260e6e08219a4c01',
       i686: '323c6835faa6eab76bbb06885fd6ec0d22ef4b2c7d544f9ee308096a9f2696a1',
     x86_64: '534e93013ff7ec79a8ce65214b2cca14d5912873aadc5ecb72b0b6fc262446a3'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
