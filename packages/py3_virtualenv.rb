require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.26.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f368e469d1041a22a8c848731822d0323ec52151826d48d2896e7f8b8cd3bcfa',
     armv7l: 'f368e469d1041a22a8c848731822d0323ec52151826d48d2896e7f8b8cd3bcfa',
       i686: '7230d8f501ef7ef43a7dc552d39f14880b9ae801e3af8aca09901c86f94169ba',
     x86_64: 'd93d81be37df3c1c3943e4b05be40182efc4209a53f67c29e8cba624d1624e9f'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
