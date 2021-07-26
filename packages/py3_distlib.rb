require 'package'

class Py3_distlib < Package
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  @_ver = '0.3.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://bitbucket.org/pypa/distlib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.1_armv7l/py3_distlib-0.3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.1_armv7l/py3_distlib-0.3.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.1_x86_64/py3_distlib-0.3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '65978b1ac26d1fbed2e6d52b206556b5c73d97eb3b1df265ae0c697fa85b7987',
     armv7l: '65978b1ac26d1fbed2e6d52b206556b5c73d97eb3b1df265ae0c697fa85b7987',
     x86_64: '58c20fa460e47d16141c1e33482443e98b479c080cb2460df950a5d74b9e152f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
