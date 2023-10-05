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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-py3.12_armv7l/py3_appdirs-1.4.4-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-py3.12_armv7l/py3_appdirs-1.4.4-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-py3.12_i686/py3_appdirs-1.4.4-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-py3.12_x86_64/py3_appdirs-1.4.4-py3.12-chromeos-x86_64.tar.zst'
  })
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
