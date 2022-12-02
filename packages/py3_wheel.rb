require 'package'

class Py3_wheel < Package
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  @_ver = '0.38.4'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.38.4-py3.11_armv7l/py3_wheel-0.38.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.38.4-py3.11_armv7l/py3_wheel-0.38.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.38.4-py3.11_i686/py3_wheel-0.38.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.38.4-py3.11_x86_64/py3_wheel-0.38.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '87c443d42f54772f3ff26c871dafde7a2058315b27e8de958df100594921c828',
     armv7l: '87c443d42f54772f3ff26c871dafde7a2058315b27e8de958df100594921c828',
       i686: '05b0d55b07d56b2b3743d2ce6e1af8d849cf5424f3af51023352884d5e802f40',
     x86_64: 'e20a4e37c977a37b0c28fd363d78e95593f5f519ef67f87cb16dfacfcb4a0a8a'
  })

  depends_on 'python3'
  depends_on 'py3_setuptools' => :build
  depends_on 'py3_packaging'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
