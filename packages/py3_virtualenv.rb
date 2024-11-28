require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.28.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd80bcf9d1c63ab66c93a853123e20fbf731ed77c656003dec70af27f7ebcd1c3',
     armv7l: 'd80bcf9d1c63ab66c93a853123e20fbf731ed77c656003dec70af27f7ebcd1c3',
       i686: '3d93cbb2df549028e822aacd61f616a79f79a68d075d9b5eb1ba63ea5fd2c2a2',
     x86_64: '2b98b60bc20ebf9db7e464236111d8dc80a717d064e6bf39ef5b8a5b477360c7'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
