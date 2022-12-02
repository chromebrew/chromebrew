require 'package'

class Py3_oci < Package
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  @_ver = '2.47.1'
  version "#{@_ver}-py3.11"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oracle/oci-python-sdk.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1-py3.11_armv7l/py3_oci-2.47.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1-py3.11_armv7l/py3_oci-2.47.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1-py3.11_i686/py3_oci-2.47.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_oci/2.47.1-py3.11_x86_64/py3_oci-2.47.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'aa3ca7e5f37b90b50934664058c7b924fb30498e51817ef7f3099a346af1efea',
     armv7l: 'aa3ca7e5f37b90b50934664058c7b924fb30498e51817ef7f3099a346af1efea',
       i686: 'fc0dcdb2c1d3c8e9927b1cf7568a44e464496fcce1a15814cbc52d7c87d5f960',
     x86_64: '7a15dcdc16fd5d464c85ab88be27484fcc8b6f12f6d17fac19d4b0a08afe2610'
  })

  depends_on 'py3_dateutil'
  depends_on 'py3_configparser'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_certifi'
  depends_on 'py3_pytz'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
