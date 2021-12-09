require 'package'

class Py3_leather < Package
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  @_ver = '0.3.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/leather.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4_armv7l/py3_leather-0.3.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4_armv7l/py3_leather-0.3.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4_i686/py3_leather-0.3.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4_x86_64/py3_leather-0.3.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1a1eb059dbb9caa8f20c53c7e71b4b23c1931a6587ecb43166f767cee8c840b1',
     armv7l: '1a1eb059dbb9caa8f20c53c7e71b4b23c1931a6587ecb43166f767cee8c840b1',
       i686: '2137d4c5d5d7334974f3f3f580434427c36a91e95b06e62caf5352b55d1a0530',
     x86_64: 'e2af8d01d60392799ee3a8bf4624b4df30b4644288da9df8226e3386d9cc1313'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
