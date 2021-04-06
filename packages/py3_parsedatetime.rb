require 'package'

class Py3_parsedatetime < Package
  description 'ISOdate is an ISO 8601 date/time parser.'
  homepage 'https://github.com/bear/parsedatetime/'
  version '2.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bear/parsedatetime/archive/v2.6.tar.gz'
  source_sha256 '0cbf3fe4dee18c88df343bc568d35fdc67774846cb4aec2b2626d1bee7a0c6c5'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
