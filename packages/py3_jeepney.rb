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
    aarch64: 'f784819a2141cbfc196954ffb42b0b1fac8b7674b4a6f4fd0a2a94ba5172aa80',
     armv7l: 'f784819a2141cbfc196954ffb42b0b1fac8b7674b4a6f4fd0a2a94ba5172aa80',
       i686: '05538b051a1ec6253b27d855e1cdfd4a846f0ef629a88ecbc72be109c2998231',
     x86_64: '9305d829788457f57c25f93d5064ec381a6cfcfe9613cd9e7b46aad683a29af1'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
