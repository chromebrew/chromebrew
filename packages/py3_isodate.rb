require 'package'

class Py3_isodate < Package
  description 'ISOdate is an ISO 8601 date/time parser.'
  homepage 'https://github.com/gweis/isodate/'
  version '0.6.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/gweis/isodate/archive/0.6.0.tar.gz'
  source_sha256 'ce43efbfa412a8a8949ce2477c2abaee02f1eac7600b63d8d6ca8cbdfbc855c9'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
