require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9fa00799b20d2a39a989ef852cc4e2308e8dbe58f32ebdbd784c8d99ee2ee1d2',
     armv7l: '9fa00799b20d2a39a989ef852cc4e2308e8dbe58f32ebdbd784c8d99ee2ee1d2',
       i686: '62b9cf18149ad8fca81d012bd666bb1ddae022c160dad4d10f32b60f9f7123ea',
     x86_64: 'b9e6da51faefb2b19c75168f08971cb4e9f6e94c8c3deb6758ca31bce10638ca'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
