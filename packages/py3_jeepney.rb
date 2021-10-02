require 'package'

class Py3_jeepney < Package
  description 'Jeepney is a low-level, pure Python DBus protocol wrapper.'
  homepage 'https://gitlab.com/takluyver/jeepney/'
  @_ver = '0.7.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/8e/9b/72259ccc9c49cf830f60289c841d57a449d993f48de0df5e76b3f9d929ae/jeepney-0.7.0.tar.gz'
  source_sha256 '1237cd64c8f7ac3aa4b3f332c4d0fb4a8216f39eaa662ec904302d4d77de5a54'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.0_armv7l/py3_jeepney-0.7.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.0_armv7l/py3_jeepney-0.7.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.0_x86_64/py3_jeepney-0.7.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f6d662b0d518b94df727fb08e6fb76f43f346f8fcb164c7eada2622aa59c39fc',
     armv7l: 'f6d662b0d518b94df727fb08e6fb76f43f346f8fcb164c7eada2622aa59c39fc',
     x86_64: 'c28d755bd64f0b335792f0059833640bb7b175ea51695a4ec56d362315f35190'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
