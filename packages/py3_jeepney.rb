require 'package'

class Py3_jeepney < Package
  description 'Jeepney is a low-level, pure Python DBus protocol wrapper.'
  homepage 'https://gitlab.com/takluyver/jeepney/'
  @_ver = '0.7.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/09/0d/81744e179cf3aede2d117c20c6d5b97a62ffe16b2ca5d856e068e81c7a68/jeepney-0.7.1.tar.gz'
  source_sha256 'fa9e232dfa0c498bd0b8a3a73b8d8a31978304dcef0515adc859d4e096f96f4f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.1_armv7l/py3_jeepney-0.7.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.1_armv7l/py3_jeepney-0.7.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.1_i686/py3_jeepney-0.7.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.1_x86_64/py3_jeepney-0.7.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e38b5e0d403620f6fe5bb64b3e36dbad3f7b90b1226d9637ca0f66f6e0a00987',
     armv7l: 'e38b5e0d403620f6fe5bb64b3e36dbad3f7b90b1226d9637ca0f66f6e0a00987',
       i686: '6e1e34bb544bf2549dd3d2983ccbd30dfb6a8d38d94f610d35b8ee7064ac406c',
     x86_64: '1062070275f5322c14f2f17e623feb84569331f26ee522dd2b0cc243105294db'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
