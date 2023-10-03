require 'package'

class Py3_wheel < Package
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  @_ver = '0.41.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.41.2-py3.12_armv7l/py3_wheel-0.41.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.41.2-py3.12_armv7l/py3_wheel-0.41.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.41.2-py3.12_i686/py3_wheel-0.41.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.41.2-py3.12_x86_64/py3_wheel-0.41.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3040c6319195bdeae9bf81a4082c77468ac1c72662423eae041a8906db142d94',
     armv7l: '3040c6319195bdeae9bf81a4082c77468ac1c72662423eae041a8906db142d94',
       i686: '436bec462bbeb979f98db3bea8029e5c6f80aaa1a4c9b685981806cf12d0212a',
     x86_64: '31a31bef275b97191787b4c7eab857f70f548eceb94e01da47e03c9aa3b1d9ce'
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
