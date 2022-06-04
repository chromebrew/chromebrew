require 'package'

class Py3_wheel < Package
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  @_ver = '0.37.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.1-1_armv7l/py3_wheel-0.37.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.1-1_armv7l/py3_wheel-0.37.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.1-1_i686/py3_wheel-0.37.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.1-1_x86_64/py3_wheel-0.37.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '19030adb5c9a78e4d76b1b6e7fa1b1ead2a15d7b5160e566d81cf3acd3b2375b',
     armv7l: '19030adb5c9a78e4d76b1b6e7fa1b1ead2a15d7b5160e566d81cf3acd3b2375b',
       i686: '1b56af7cc567d1001d4a33438bebfd651bce7d02194dd42a1fedd13cf9541ec8',
     x86_64: 'aa2d8f45650a8afc9be0249124181b669694338264115e84803ba061b60fe155'
  })

  depends_on 'py3_setuptools' => :build
  depends_on 'py3_packaging'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
