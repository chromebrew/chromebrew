require 'package'

class Py3_zipp < Package
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  @_ver = '3.6.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/zipp.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0_armv7l/py3_zipp-3.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0_armv7l/py3_zipp-3.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0_i686/py3_zipp-3.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0_x86_64/py3_zipp-3.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '962fca0ee3048448eb4c22e6dbd8794b57b3c5d66b21df83c1d3e7d6764c0ea7',
     armv7l: '962fca0ee3048448eb4c22e6dbd8794b57b3c5d66b21df83c1d3e7d6764c0ea7',
       i686: '5799e3de71fd450a1abdaa528a4d4fa6ed27f82a08085b6c214027bdd4c98975',
     x86_64: 'a20a4195e5ba929b856b4b6427a8945e8d4c41187b0cf9b670d1fbc21f7a6409'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
