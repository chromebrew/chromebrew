require 'package'

class Py3_pyte < Package
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  @_ver = '0.8.0'
  version "#{@_ver}-1"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/selectel/pyte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-1_armv7l/py3_pyte-0.8.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-1_armv7l/py3_pyte-0.8.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-1_i686/py3_pyte-0.8.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-1_x86_64/py3_pyte-0.8.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3a9c528242235dbf6cfc01e98ba2c9021ac16417423fdde7837ff9024a1fbdb5',
     armv7l: '3a9c528242235dbf6cfc01e98ba2c9021ac16417423fdde7837ff9024a1fbdb5',
       i686: '4067e2e6dab3b86560f0a7724ae94ff406e631757663c47fd34cda9bc52499c3',
     x86_64: '9799ee424583d37d4041ad65f590e0c5ff4650d0be3b6cc1395a31a1ca329237'
  })

  depends_on 'py3_wcwidth'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
