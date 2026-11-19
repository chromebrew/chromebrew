require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f66d84f15d484730f529e3c50b0ae49417ef4de49c699ad57d32e22d52a34bd0',
     armv7l: 'f66d84f15d484730f529e3c50b0ae49417ef4de49c699ad57d32e22d52a34bd0',
       i686: '0fd6ec6679d7af06476e907b30417fb3d08e7f1c01a6d3802bb27db4121fdad0',
     x86_64: 'd571a83acfdbabe2244b74e6a57e1413e74b6ed8c9298523fbc4c3daa5cf4adf'
  })

  depends_on 'python3' => :logical

  no_source_build
end
