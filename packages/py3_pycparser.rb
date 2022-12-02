require 'package'

class Py3_pycparser < Package
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  @_ver = '2.21'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/eliben/pycparser.git'
  git_hashtag "release_v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycparser/2.21-py3.11_armv7l/py3_pycparser-2.21-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycparser/2.21-py3.11_armv7l/py3_pycparser-2.21-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycparser/2.21-py3.11_i686/py3_pycparser-2.21-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycparser/2.21-py3.11_x86_64/py3_pycparser-2.21-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bdc292c1677a3998ebe26ba56fe728ba322f6e679faf18850ad742728fac7b3c',
     armv7l: 'bdc292c1677a3998ebe26ba56fe728ba322f6e679faf18850ad742728fac7b3c',
       i686: 'd7d6ff2cf84b41a82cfe249c72010803f465d07019777eec05692641c1606a16',
     x86_64: '7d22bed99ec1dbbe572a234c1cf7bcd17849335954a521c0c4c86a118364c14c'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
