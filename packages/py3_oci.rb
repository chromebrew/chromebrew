require 'package'

class Py3_oci < Package
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  @_ver = '2.38.1'
  version @_ver
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oracle/oci-python-sdk.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.38.1_x86_64/py3_oci-2.38.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: 'd8405fcf598555bd2e060fd2549ac055b09d086a6d4f96abda982a9b0d48697e'
  })

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
