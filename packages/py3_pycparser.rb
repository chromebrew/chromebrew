require 'package'

class Py3_pycparser < Package
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  @_ver = '2.21'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/eliben/pycparser.git'
  git_hashtag "release_v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycparser/2.21_armv7l/py3_pycparser-2.21-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycparser/2.21_armv7l/py3_pycparser-2.21-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycparser/2.21_i686/py3_pycparser-2.21-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycparser/2.21_x86_64/py3_pycparser-2.21-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7c9cbd663a180226c1688c99c2ae9fd650bd46a8581e7538b1a63d557ded94cd',
     armv7l: '7c9cbd663a180226c1688c99c2ae9fd650bd46a8581e7538b1a63d557ded94cd',
       i686: 'a43749ca7aceccda4465573ae593fbd4056a6ec57d331da5b8c48d3151d45af4',
     x86_64: 'b3a54f1e0a3dd3d27a6cd3cc3a578f91cd91507d8e6e15c85b5ad29d57bfe49c'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
