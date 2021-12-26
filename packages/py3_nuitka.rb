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

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
