require 'package'

class Py3_pyasn1 < Package
  description 'Pyasn1 provides ASN.1 types and codecs.'
  homepage 'http://snmplabs.com/pyasn1/'
  version '0.4.8'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/etingof/pyasn1/archive/v0.4.8.tar.gz'
  source_sha256 '1baa319ca6e30ffed0d23198d2100742e9e8b5cae464135d69058d0d6069aafc'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
