require 'package'

class Py3_oci < Package
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  @_ver = '2.47.1'
  version @_ver
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oracle/oci-python-sdk.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1_armv7l/py3_oci-2.47.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1_armv7l/py3_oci-2.47.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1_i686/py3_oci-2.47.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1_x86_64/py3_oci-2.47.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5d86993783651e32978610bf6ef35bc5f7204b982d9c97569faf6e46efd25471',
     armv7l: '5d86993783651e32978610bf6ef35bc5f7204b982d9c97569faf6e46efd25471',
       i686: 'aae5523e9d97e038cf5dc4763597e37940f0b057e17083c3d85d5080411109f4',
     x86_64: '99649cc221142e93cca0bb6473c7300799792f1c2fa9e49862f4bc61cffc19fb'
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
