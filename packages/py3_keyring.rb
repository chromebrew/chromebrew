require 'package'

class Py3_keyring < Package
  description 'The Python keyring library provides an easy way to access the system keyring service from python.'
  homepage 'https://github.com/jaraco/keyring/'
  version '23.0.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/b0/b5/b27458e1d2adf2a11c6e95c67ac63f828e96fe7e166132e5dacbe03e88c0/keyring-23.0.1.tar.gz'
  source_sha256 '045703609dd3fccfcdb27da201684278823b72af515aedec1a8515719a038cb8'

#  depends_on 'dbus_python' # Only if KWallet is installed, which is not packaged for chromebrew yet.
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
