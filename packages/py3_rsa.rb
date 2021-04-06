require 'package'

class Py3_rsa < Package
  description 'RSA is a pure python RSA implementation.'
  homepage 'https://stuvel.eu/software/rsa/'
  version '4.7.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/sybrenstuvel/python-rsa/archive/version-4.7.2.tar.gz'
  source_sha256 '6717dd652021c1c90a4a5457042f9c0c3c0f50533065aa0f5ed3a8c6ab1d0e92'

  depends_on 'py3_pyasn1'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
