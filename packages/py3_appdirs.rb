require 'buildsystems/python'

class Py3_appdirs < Python
  description 'Appdirs is a small Python module for determining appropriate platform-specific directories.'
  homepage 'https://github.com/ActiveState/appdirs/'
  @_ver = '1.4.4'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ActiveState/appdirs.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '330c36c0015c417d95cb1f27c13e8c588077875ae333fd9b89d0a17aae10bb32',
     armv7l: '330c36c0015c417d95cb1f27c13e8c588077875ae333fd9b89d0a17aae10bb32',
       i686: '169b9bc778f9a3631b609cfe8bcb5fa8d12a3dd0b939b08050d9b6af615c473d',
     x86_64: '8d0042dc4f89e59b7a8400dd3dd87a159c59b4e695751e67defcc5a1dac974a8'
  })

  depends_on 'python3' => :build

  def postinstall
    puts 'Note this has been DEPRECATED in favor of https://pypi.org/project/platformdirs/'.orange
  end
end
