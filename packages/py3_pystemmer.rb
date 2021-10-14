require 'package'

class Py3_pystemmer < Package
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  @_ver = '2.0.1'
  version @_ver + '-1'
  license 'BSD MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/55/b2/c3aeebfe4a60256ddb72257e750a94c26c3085f017b7e58c860d5aa91432/PyStemmer-2.0.1.tar.gz'
  source_sha256 '9b81c35302f1d2a5ad9465b85986db246990db93d97d3e8f129269ed7102788e'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
