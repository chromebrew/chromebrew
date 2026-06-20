require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.34-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4be72cf8731aa4aa4bb61177de80d3ea3e2eda31b9e5f8107dd8d61cee4c2864',
     armv7l: '4be72cf8731aa4aa4bb61177de80d3ea3e2eda31b9e5f8107dd8d61cee4c2864',
       i686: 'c746f6362d2bb9b75e712197dc504c76a0e5c667a079b28d92573f2771c75f03',
     x86_64: '73642e254051727776caf27106f0f4d7a14eff08e90ab74c62d9b95fee9381c7'
  })

  depends_on 'python3' => :logical

  no_source_build
end
