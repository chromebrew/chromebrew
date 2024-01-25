require 'package'

class Py3_typing_extensions < Package
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  @_ver = '4.2.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python/typing.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'baa7f1c17ab1c1732a08acf814ea61550cba26075b1a69492ee07d8346a13e25',
     armv7l: 'baa7f1c17ab1c1732a08acf814ea61550cba26075b1a69492ee07d8346a13e25',
       i686: 'da35c6f1dc600b188f87223d478f27a4bee7f89c7dfb1513b43b29b403559094',
     x86_64: '2cef12f43c51a6389f279f98b59075383431b29b599e8e8d559d6f124261c42d'
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
