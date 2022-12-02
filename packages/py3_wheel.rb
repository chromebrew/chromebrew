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
    aarch64: 'e09e5d9ff60863d7b57313f881b33ea8099ec0b53959f31aee776ffb571559f8',
     armv7l: 'e09e5d9ff60863d7b57313f881b33ea8099ec0b53959f31aee776ffb571559f8',
       i686: '6b42d8c7e0208d36acd186bd747a76c22e77cf0fe1a57035f0f920b25db4df57',
     x86_64: '78e005cc0c9a6606d9c269c99196f797f7ebdc648724ffb74f967427b56dd279'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
