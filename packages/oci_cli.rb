require 'package'

class Oci_cli < Package
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  @_ver = '2.24.3'
  version @_ver
  license 'UPL-1.0'
  compatibility 'all'
  source_url 'https://github.com/oracle/oci-cli.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/oci_cli/2.24.3_i686/oci_cli-2.24.3-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/oci_cli/2.24.3_x86_64/oci_cli-2.24.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '3d78eadfca689d3949ad0083de9e81cb54a0cac1284be351a6ef0415e902ff74',
  x86_64: '8732fa4c8469aff32e587a43a3065064ac21aba6afef70187628d934929eb735'
  })

  depends_on 'py3_arrow'
  depends_on 'py3_six'
  depends_on 'py3_terminaltables'
  depends_on 'py3_certifi'
  depends_on 'py3_dateutil'
  depends_on 'py3_click'
  depends_on 'py3_jmespath'
  depends_on 'py3_retrying'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_pyyaml'
  depends_on 'py3_cryptography'
  depends_on 'py3_configparser'
  depends_on 'py3_pytz'
  depends_on 'py3_oci'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
