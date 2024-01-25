require 'buildsystems/python'

class Py3_pygments < Python
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  @_ver = '2.16.1'
  version "#{@_ver}-py3.12"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/pygments/pygments.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e5e565ab22ad338bf66569189ef0f7a7178fec541100eee7cfd4d0dca8965158',
     armv7l: 'e5e565ab22ad338bf66569189ef0f7a7178fec541100eee7cfd4d0dca8965158',
       i686: '8048104f5cd85d39d378e36981de22387ea4283f2bff2bc49062e0b705a5ff8a',
     x86_64: 'ba7aa0d389af7a2d92ecdfeea5b505bfa8957b061aed09ffaf898df8ef2a9dfb'
  })

  depends_on 'python3' => :build
end
