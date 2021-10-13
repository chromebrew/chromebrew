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
    aarch64: '987772d193fe002b9896262193cf86304b62f9f96445bb9df642ecdca4eba7dd',
     armv7l: '987772d193fe002b9896262193cf86304b62f9f96445bb9df642ecdca4eba7dd',
     x86_64: '33d2a11a663b3beb60a9af8a91d6128af06dc2b2dc82370cf905131e9f95c820'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
