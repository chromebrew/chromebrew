require 'package'

class Py3_pytz < Package
  description 'Pytz brings the IANA tz database into python.'
  homepage 'http://pythonhosted.org/pytz/'
  version '2021.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/b0/61/eddc6eb2c682ea6fd97a7e1018a6294be80dba08fa28e7a3570148b4612d/pytz-2021.1.tar.gz'
  source_sha256 '83a4a90894bf38e243cf052c8b58f381bfe9a7a483f6a9cab140bc7f702ac4da'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
