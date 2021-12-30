require 'package'

class Py3_typing_extensions < Package
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  @_ver = '3.10.0.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python/typing.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/3.10.0.2_armv7l/py3_typing_extensions-3.10.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/3.10.0.2_armv7l/py3_typing_extensions-3.10.0.2-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/3.10.0.2_i686/py3_typing_extensions-3.10.0.2-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/3.10.0.2_x86_64/py3_typing_extensions-3.10.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '875a9d01bd5b2278d76d08eac6dbe36f101971d399334a37c5ab027572e57547',
     armv7l: '875a9d01bd5b2278d76d08eac6dbe36f101971d399334a37c5ab027572e57547',
    i686: '6e666acbf01d30cba8039df63fbecfbf03c3dd8efa6a4aaab8bea74f0d74df79',
  x86_64: '799e539caecc34de8de31dfe1105560b3d8e7d66d0fe05bd3d1e0095d49b4ad8'
  })

  depends_on 'python3'
  depends_on 'py3_setuptools'
  depends_on 'py3_wheel'

  def self.build
    Dir.chdir 'typing_extensions' do
      system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir 'typing_extensions' do
      system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
    end
  end
end
