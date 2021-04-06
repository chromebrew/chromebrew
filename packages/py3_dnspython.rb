require 'package'

class Py3_dnspython < Package
  description 'dnspython is a DNS toolkit for python.'
  homepage 'https://www.dnspython.org/'
  version '2.1.0'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/rthalley/dnspython/archive/v2.1.0.tar.gz'
  source_sha256 '7406a6f754abad3f47309d808f14d544f7e3cc50094d6232bbe1ddb1cfc408a2'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
