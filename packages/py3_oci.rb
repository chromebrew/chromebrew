require 'package'

class Py3_oci < Package
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  @_ver = '2.38.1'
  version @_ver
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oracle/oci-python-sdk.git'
  git_hashtag @_ver

  depends_on 'py3_dateutil'
  depends_on 'py3_configparser'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_certifi'
  depends_on 'py3_pytz'
  depends_on 'py3_cryptography'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
