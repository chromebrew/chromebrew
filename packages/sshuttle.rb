require 'package'

class Sshuttle < Package
  description 'Full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle/'
  @_ver = '1.0.5'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/sshuttle/sshuttle.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_psutil'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
