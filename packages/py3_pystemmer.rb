require 'package'

class Py3_pystemmer < Package
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  @_ver = '2.0.1'
  version "#{@_ver}-1"
  license 'BSD MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/55/b2/c3aeebfe4a60256ddb72257e750a94c26c3085f017b7e58c860d5aa91432/PyStemmer-2.0.1.tar.gz'
  source_sha256 '9b81c35302f1d2a5ad9465b85986db246990db93d97d3e8f129269ed7102788e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-1_armv7l/py3_pystemmer-2.0.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-1_armv7l/py3_pystemmer-2.0.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-1_i686/py3_pystemmer-2.0.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-1_x86_64/py3_pystemmer-2.0.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b3e54cf7a3a8f33699204e46f73fc635d74169ac665686eb4a27a22079196c8a',
     armv7l: 'b3e54cf7a3a8f33699204e46f73fc635d74169ac665686eb4a27a22079196c8a',
       i686: 'fc5d4e785251e5765fc30f946865b7fdadcceeeeb9c12230fb74ef8b9b12fcde',
     x86_64: 'f370c5460703abf5fb8f3804c16b7807f75d4cc4da984f0a5b04dfc2d64301ef'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
