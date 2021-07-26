require 'package'

class Py3_pystemmer < Package
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  version '2.0.1'
  license 'BSD MIT'
  compatibility 'x86_64'
  source_url 'https://pypi.io/packages/source/P/PyStemmer/PyStemmer-2.0.1.tar.gz'
  source_sha256 '9b81c35302f1d2a5ad9465b85986db246990db93d97d3e8f129269ed7102788e'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1_x86_64/py3_pystemmer-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: '10d004a45733854bbd67e03133c60eaac0e52ce40d9ee7dbe0a64fa59b6717a4'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
