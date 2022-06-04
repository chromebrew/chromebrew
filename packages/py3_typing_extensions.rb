require 'package'

class Py3_typing_extensions < Package
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  @_ver = '4.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python/typing.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/4.2.0_armv7l/py3_typing_extensions-4.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/4.2.0_armv7l/py3_typing_extensions-4.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/4.2.0_i686/py3_typing_extensions-4.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typing_extensions/4.2.0_x86_64/py3_typing_extensions-4.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9baac14e75c9895e521e684f4054e4c97b193eb74175d9dbd90850427f1f8b09',
     armv7l: '9baac14e75c9895e521e684f4054e4c97b193eb74175d9dbd90850427f1f8b09',
       i686: 'b71a96ab82d2034598be84eaf0dc3b8f0e1b7215f454668766fa3aae847de6cf',
     x86_64: '211c1c352eda292eef3783cb5de11f7d744ab94699f70625e8aecc2fc141f987'
  })

  depends_on 'py3_setuptools' => :build

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
