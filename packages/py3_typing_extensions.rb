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

  depends_on 'py3_setuptools' => :build

  def self.build
    Dir.chdir 'typing_extensions' do
      system "python3 -m build #{PY3_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir 'typing_extensions' do
      system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
    end
  end
end
