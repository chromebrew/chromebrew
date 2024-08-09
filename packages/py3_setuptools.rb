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
    aarch64: '5365ac36cf205911283005414f50d2d1d100a527678b3343058abda6675cfff9',
     armv7l: '5365ac36cf205911283005414f50d2d1d100a527678b3343058abda6675cfff9',
       i686: 'd24f343a04d8cefdcb132c38c1d5cbee3992f72416eff1a4a5f9b5eb2e482c34',
     x86_64: '416b19dfef5ab021a7248fe33f27082275e228ce8a0321227bd80695302d4e1f'
  })

  depends_on 'python3', '< 3.13.0'
  depends_on 'py3_packaging'

  conflicts_ok
end
