require 'package'

class Py3_ply < Package
  description 'Python Lex/Yacc is an implementation of lex and yacc parsing tools for Python.'
  homepage 'https://www.dabeaz.com/ply/index.html'
  @_ver = '3.11'
  version @_ver + '-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz'
  source_sha256 '00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
