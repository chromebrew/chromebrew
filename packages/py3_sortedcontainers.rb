require 'package'

class Py3_sortedcontainers < Package
  description 'Python Sorted Container Types: Sorted List, Sorted Dict, and Sorted Set'
  homepage 'http://www.grantjenks.com/docs/sortedcontainers/'
  @_ver = '2.4.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/grantjenks/python-sortedcontainers.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0_armv7l/py3_sortedcontainers-2.4.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0_armv7l/py3_sortedcontainers-2.4.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0_i686/py3_sortedcontainers-2.4.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0_x86_64/py3_sortedcontainers-2.4.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7bc5404084294d14e4cf0bff54013fff3a27213509baad79e80a280212474043',
     armv7l: '7bc5404084294d14e4cf0bff54013fff3a27213509baad79e80a280212474043',
       i686: 'e82ddb9e71a7c60ce43354e3f74337d0018e1c646609b197b6fa31336f5209b4',
     x86_64: 'c40ada805815e43c05ccc4efc99abff2748ac93a723c193aa1a4b6cd2b73834d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
