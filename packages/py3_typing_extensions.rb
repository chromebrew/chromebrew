require 'package'

class Py3_typing_extensions < Package
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  @_ver = '4.2.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python/typing.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/4.2.0-py3.11_armv7l/py3_typing_extensions-4.2.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/4.2.0-py3.11_armv7l/py3_typing_extensions-4.2.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/4.2.0-py3.11_i686/py3_typing_extensions-4.2.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/4.2.0-py3.11_x86_64/py3_typing_extensions-4.2.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0d7fcfe93fdf9cb2193f35806afd7d53b5406b0e537f714b0bd8522e2f1f3013',
     armv7l: '0d7fcfe93fdf9cb2193f35806afd7d53b5406b0e537f714b0bd8522e2f1f3013',
       i686: '14ae3af6f12d491e58271a8ef24d1620c0b119534b710c57537ff9be323d7446',
     x86_64: 'b7eea615705e3f2c048d5ad803c88d02c9a4ea5ec59603137beeaa0a41382812'
  })

  depends_on 'python3' => :build

  def self.build
    Dir.chdir 'typing_extensions' do
      system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir 'typing_extensions' do
      system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
    end
  end
end
