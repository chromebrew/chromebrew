require 'buildsystems/python'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '72.1.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '384a9409c7950ef50f2a090dc4174b633fc22b78843913bc7f4918b3ce9f95a9',
     armv7l: '384a9409c7950ef50f2a090dc4174b633fc22b78843913bc7f4918b3ce9f95a9',
       i686: '16c759bdccf5fea36f1c6696d59791579ffb74d99f8992607d69ad8164e76972',
     x86_64: '384d48bf7b74210e21b4f46a966d97c4cf98eb58854c26df3fcf56f647c877fe'
  })

  depends_on 'python3', '< 3.13.0'
  depends_on 'py3_packaging'

  conflicts_ok
end
