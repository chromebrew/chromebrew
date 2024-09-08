require 'buildsystems/pip'

class Py3_appdirs < Pip
  description 'Appdirs is a small Python module for determining appropriate platform-specific directories.'
  homepage 'https://github.com/ActiveState/appdirs/'
  version '1.4.4-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build

  def postinstall
    puts 'Note this has been DEPRECATED in favor of https://pypi.org/project/platformdirs/'.orange
  end
end
