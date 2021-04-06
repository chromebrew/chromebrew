require 'package'

class Py3_botocore < Package
  description 'Botocore is the low-level, data-driven core of boto 3.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.20.45'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/boto/botocore/archive/1.20.45.tar.gz'
  source_sha256 'f4a72ab2c2149e4835b125e7b1d165a82b8f71263ba12ff047a30447765f12c0'

  depends_on 'py3_dateutil'
  depends_on 'py3_jmespath'
  depends_on 'py3_urllib3'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
