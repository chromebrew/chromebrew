require 'package'

class Gyp_next < Package
  description 'GYP is a fork of the GYP build system for use in the Node.js projects.'
  homepage 'https://github.com/nodejs/gyp-next/'
  @_ver = '0.8.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gyp_next/0.8.1_armv7l/gyp_next-0.8.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gyp_next/0.8.1_armv7l/gyp_next-0.8.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gyp_next/0.8.1_x86_64/gyp_next-0.8.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '95b8ca7502843d7af0e2ed1ad85b27e426b2f7a72b345e73c3e67e4cde5b0674',
     armv7l: '95b8ca7502843d7af0e2ed1ad85b27e426b2f7a72b345e73c3e67e4cde5b0674',
     x86_64: 'f0d7e59aee2f08b5b0a9b40b7daef3b8a85c850d46dc73fcc33ad1a6eacd11e5'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
