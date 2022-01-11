require 'package'

class Py3_nuitka < Package
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  @_ver = '0.6.18.5'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/78/b3/e8b6f9d728454a1be16bcc4921e5ea55804587d89e8f8637c89d33ae11da/Nuitka-0.6.18.5.tar.gz'
  source_sha256 'a9c7b49d0bd6ae73fe299772b0f2ae95e6d5d9a20de128932bcc5b92826f0ea7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.18.5_armv7l/py3_nuitka-0.6.18.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.18.5_armv7l/py3_nuitka-0.6.18.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.18.5_i686/py3_nuitka-0.6.18.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.18.5_x86_64/py3_nuitka-0.6.18.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '28fcd09039c0d12758806a8d8083ec410ce73c6382581906cf4934fb6f4ebff4',
     armv7l: '28fcd09039c0d12758806a8d8083ec410ce73c6382581906cf4934fb6f4ebff4',
       i686: 'bd1f33a43e05eb874706a1b90bfc80dcdd085442cf6c6414bd6c25f7b71e9faa',
     x86_64: '26a84ef600a85bed53bb9f5cf8eb6202c8686389908061588f08fa52f9b6737a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
