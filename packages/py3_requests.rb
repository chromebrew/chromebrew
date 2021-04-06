require 'package'

class Py3_requests < Package
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://requests.readthedocs.io/'
  version '2.25.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/psf/requests/archive/v2.25.1.tar.gz'
  source_sha256 '03b192fad682a33964df331d35f90918b1940c89f6c5bcb10060be688ba50315'

  depends_on 'py3_setuptools' => :build
  depends_on 'py3_certifi'
  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_lxml'
  depends_on 'py3_urllib3'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
