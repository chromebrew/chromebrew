require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '804ea3326137401f32c765dfa515861f8e35a7f3425eee665f0b988db0651b7e',
     armv7l: '804ea3326137401f32c765dfa515861f8e35a7f3425eee665f0b988db0651b7e',
       i686: 'df4296eb4ab33608038809d8eb643088fe671cf87fd3a6e554592be3cfe4ea3f',
     x86_64: 'a6e1a0ff3054290f7ded7911672463a864d5e26aaa8f83582b867bdef6aeb125'
  })

  depends_on 'python3' => :logical

  no_source_build
end
