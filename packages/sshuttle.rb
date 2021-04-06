require 'package'

class Sshuttle < Package
  description 'Sshuttle is a full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle/'
  version '1.0.5'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e9/4b/51d6aaa900a6a13efb380b0a084a327c41aad28a267d4c1f074cb2e41baa/sshuttle-1.0.5.tar.gz'
  source_sha256 'fd8c691aac2cb80933aae7f94d9d9e271a820efc5c48e73408f1a90da426a1bd'

  depends_on 'py3_psutil'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
