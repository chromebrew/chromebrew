require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.9.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e11e008045cbb799bb1072fbd95b7127410341b93b73a0671efac9df9a3a3e80',
     armv7l: 'e11e008045cbb799bb1072fbd95b7127410341b93b73a0671efac9df9a3a3e80',
       i686: 'ffff5a385307b80eb32c89f2e579e54e6b098f9db0df1550c972af7e31fdd6ba',
     x86_64: '4c29ca59518c5902f9f51f3f8b74247874bd9ed2e7b35944417f34c4e42ecae8'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
