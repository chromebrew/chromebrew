require 'package'

class Py3_typing_extensions < Package
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version '4.12.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python/typing.git'
  version '4.12.2-py3.12'
  binary_compression 'tar.zst'


  depends_on 'python3' => :build

  def self.build
    Dir.chdir 'typing_extensions' do
  version '4.12.2-py3.12'
    end
  end

  def self.install
    Dir.chdir 'typing_extensions' do
      system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
    end
  end
end
