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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.38.1_armv7l/py3_oci-2.38.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.38.1_armv7l/py3_oci-2.38.1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1_i686/py3_oci-2.47.1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1_x86_64/py3_oci-2.47.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0412d58af1bf04b702d03c3121ffd53eaf3b2143c88d4ba40336c2f340a210da',
     armv7l: '0412d58af1bf04b702d03c3121ffd53eaf3b2143c88d4ba40336c2f340a210da',
    i686: '6a1c74b95dfc81c31b1e177be7a27a07164999b2e62990996642e1135c4a00ba',
  x86_64: '8c6c4aee9c0641fa4e332ff56c2fe0fb21e9e65b5c808dccbcb42d2e5e32a281'
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
