require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version '2.13.1-icu75.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.pyicu.org/main/pyicu.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '932a8593f6cbd175a7a022c3d8a4cece0e99a62ce0b58c1f0a400055e6b00420',
     armv7l: '932a8593f6cbd175a7a022c3d8a4cece0e99a62ce0b58c1f0a400055e6b00420',
       i686: 'ab655db1f070b700cd8d47363a186a87922dea1f6a77dda8602cf9b0d15ad30a',
     x86_64: '79d0f9f55ed714d5082593ce58d502ca4ff876198e08f79c736fa2732e2ea948'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
end
