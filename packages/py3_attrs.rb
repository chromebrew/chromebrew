require 'package'

class Py3_attrs < Package
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  @_ver = '21.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-attrs/attrs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0_armv7l/py3_attrs-21.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0_armv7l/py3_attrs-21.2.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0_x86_64/py3_attrs-21.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f6a64bcf69dd7858b2d86e6b46c43be2d233014f974edcf7e84507f35f625a99',
     armv7l: 'f6a64bcf69dd7858b2d86e6b46c43be2d233014f974edcf7e84507f35f625a99',
     x86_64: '1a4937ddeb9977bd37419a70e5191187511801ecbaee363aae89555f721b1732'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
