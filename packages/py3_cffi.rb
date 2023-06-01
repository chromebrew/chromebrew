require 'package'

class Py3_cffi < Package
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  @_ver = '1.15.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/2b/a8/050ab4f0c3d4c1b8aaa805f70e26e84d0e27004907c5b8ecc1d31815f92a/cffi-1.15.1.tar.gz'
  source_sha256 'd400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.1-py3.11_armv7l/py3_cffi-1.15.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.1-py3.11_armv7l/py3_cffi-1.15.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.1-py3.11_i686/py3_cffi-1.15.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.1-py3.11_x86_64/py3_cffi-1.15.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'feb43d20c9fa8484330e16068606a03479403a33116edf6ebde8a37d4f19912c',
     armv7l: 'feb43d20c9fa8484330e16068606a03479403a33116edf6ebde8a37d4f19912c',
       i686: '6017122ec6aee389bf2a6b0731131b64c45b245ea9e68f9c6ab1e955da07581c',
     x86_64: 'f03f003193fdd26fd6aa6945bba10bf76d15a9e0c25c19a6c6563b7b8ba31932'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # L

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
