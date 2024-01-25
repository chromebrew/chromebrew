require 'package'

class Oci_cli < Package
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version '3.1.2'
  license 'UPL-1.0'
  compatibility 'all'
  source_url 'https://github.com/oracle/oci-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'e34f28f7fd938279f2c4b4d2ea3089c1080f3f17960de056ccaba8e358a623c3',
     armv7l: 'e34f28f7fd938279f2c4b4d2ea3089c1080f3f17960de056ccaba8e358a623c3',
       i686: '6ef0ff1cbe571c15ead08e00f08c52bfd85cb6d2271a0b7ff76a8603fd98da73',
     x86_64: '409198208cd2dab9b6f66bed27413dca7e443b1917fca3d5158ae5a304905567'
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
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
