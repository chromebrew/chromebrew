require 'package'

class Py3_configparser < Package
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  @_ver = '5.0.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/configparser.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-1_armv7l/py3_configparser-5.0.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-1_armv7l/py3_configparser-5.0.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-1_i686/py3_configparser-5.0.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-1_x86_64/py3_configparser-5.0.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '141a8931a2ea2157acaa424c1462d6530787a30cfcb36dabe2fcdbf36119a287',
     armv7l: '141a8931a2ea2157acaa424c1462d6530787a30cfcb36dabe2fcdbf36119a287',
       i686: '43d374ddab7008c0863ee5c4040b4dea37d34774659eae2b32deac18c10de3fa',
     x86_64: 'a405cac91f3fae86399127303ef35108455bdbc5f238d11d32c62d280cc5158b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
