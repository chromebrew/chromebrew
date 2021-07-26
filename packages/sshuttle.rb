require 'package'

class Sshuttle < Package
  description 'Full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle/'
  @_ver = '1.0.5'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/sshuttle/sshuttle.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sshuttle/1.0.5_armv7l/sshuttle-1.0.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sshuttle/1.0.5_armv7l/sshuttle-1.0.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sshuttle/1.0.5_i686/sshuttle-1.0.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sshuttle/1.0.5_x86_64/sshuttle-1.0.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f92a3bd7c8cc9d75d5579aa4a4f2bcfe6f7761783432ee0348cca63564029134',
     armv7l: 'f92a3bd7c8cc9d75d5579aa4a4f2bcfe6f7761783432ee0348cca63564029134',
       i686: 'f9bb6e927dc48be4d11b8c5bd224f803d9a03ff06a3050990c322fae20307462',
     x86_64: '6453c1b70cc001fce9e695870d0c783c0fdfe9cbf1c69abffcc1772e1363b22f'
  })

  depends_on 'py3_psutil'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
