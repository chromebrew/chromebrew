require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.0'
  version @_ver
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_armv7l/py3_packaging-21.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_armv7l/py3_packaging-21.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_x86_64/py3_packaging-21.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '76559d3723a4f8054912eb3ba8c8c75aa98df0d57eb4a0e88d22440e10ebab3b',
     armv7l: '76559d3723a4f8054912eb3ba8c8c75aa98df0d57eb4a0e88d22440e10ebab3b',
     x86_64: '4071466cc6e1c1dd12e3bfadf3f8180d1224590722cb498f1c28c836e327418a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
