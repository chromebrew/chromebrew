require 'package'

class Sshuttle < Package
  description 'Full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle/'
  @_ver = '1.0.5'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/sshuttle/sshuttle.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sshuttle/1.0.5-1_armv7l/sshuttle-1.0.5-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sshuttle/1.0.5-1_armv7l/sshuttle-1.0.5-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sshuttle/1.0.5-1_i686/sshuttle-1.0.5-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sshuttle/1.0.5-1_x86_64/sshuttle-1.0.5-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6828c870bd62da9edb41061bf39e99383a1a53823356d6f1a443c6b86eb19f1a',
     armv7l: '6828c870bd62da9edb41061bf39e99383a1a53823356d6f1a443c6b86eb19f1a',
       i686: 'da7fdd4ddd53b363e92d2f72e871dee467c20bb7a79e00a817afc0fa037bb843',
     x86_64: '4ea4ba19a20a57fb2006b623b7c77e0e84fb9598e069ebcc67357ce50ce744b2'
  })

  depends_on 'py3_psutil'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
