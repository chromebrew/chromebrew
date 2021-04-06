require 'package'

class Py3_oci < Package
  description 'OCI is the Python SDK for Oracle Cloud Infrastructure.'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version '2.35.0'
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oracle/oci-python-sdk/archive/v2.35.0.tar.gz'
  source_sha256 '0945e1b852738c1f134e501b86ff53b34c9b504b3351d4cab427ae27f3b09696'

  depends_on 'py3_certifi'
  depends_on 'py3_cryptography'
  depends_on 'py3_dateutil'
  depends_on 'py3_pytz'
  depends_on 'py3_six'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
