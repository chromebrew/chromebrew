require 'package'

class Py3_installer < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  @_ver = '0.7.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/installer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-py3.11_armv7l/py3_installer-0.5.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-py3.11_armv7l/py3_installer-0.5.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-py3.11_i686/py3_installer-0.5.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-py3.11_x86_64/py3_installer-0.5.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0eaa647b1a6136edfe43833f79ba38790bb0bc9ae4bcc1fe46ae1bc5e863198f',
     armv7l: '0eaa647b1a6136edfe43833f79ba38790bb0bc9ae4bcc1fe46ae1bc5e863198f',
       i686: '927788c746f563cf33e7679d80cea0a0a4bd13130b0a62bae68695b7b9411a57',
     x86_64: '53925a8355f4cc7c86930629eb4d15cc63b6da56ee6f8498cd52c51c9636e7d2'
  })

  depends_on 'python3'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
