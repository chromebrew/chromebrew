require 'buildsystems/pip'

class Py3_flask < Pip
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  version "3.1.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12164ea2a39bff8a16d9db109ff1e5b39e76e6d12f2aaa2c832d49ad84de850c',
     armv7l: '12164ea2a39bff8a16d9db109ff1e5b39e76e6d12f2aaa2c832d49ad84de850c',
       i686: '99ff25608583727162f76a3966408a095a27dc348f3ae42945f5adcc59ea1c7e',
     x86_64: '8d8650994b7c7ab78de89e99c21349c93617b4cdf30baf5fb46b812074eb1a01'
  })

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
