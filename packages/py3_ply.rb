require 'package'

class Py3_ply < Package
  description 'Python Lex/Yacc is an implementation of lex and yacc parsing tools for Python.'
  homepage 'https://www.dabeaz.com/ply/index.html'
  @_ver = '3.11'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz'
  source_sha256 '00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-1_armv7l/py3_ply-3.11-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-1_armv7l/py3_ply-3.11-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-1_i686/py3_ply-3.11-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-1_x86_64/py3_ply-3.11-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6552f4fe83ede3ba0b4884d7e3e1762de43f7e6d5abeb824380fd2c1373d5616',
     armv7l: '6552f4fe83ede3ba0b4884d7e3e1762de43f7e6d5abeb824380fd2c1373d5616',
       i686: 'cdcef83e3f5493991010a1642f78dcccc3ca93f6bc824413580bc86e36d4b7c7',
     x86_64: '7a5ba2586828f37e600994ba839795290f8932a28c1aacbcff6e56b03280075e'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
