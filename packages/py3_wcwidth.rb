require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.2.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '682e71b01071dc652bd1834a9a7083dd935f937b0490e9239b9a9dcc957e3e53',
     armv7l: '682e71b01071dc652bd1834a9a7083dd935f937b0490e9239b9a9dcc957e3e53',
       i686: 'a33c39d7ac5b4a346c9ed7c78f781e973ddc7bf107b4c8426d56678290478de0',
     x86_64: '83b2afb73a755fbc1af20a77cf4e45a35d53da34779b41be55ca0d6b1e28c3f0'
  })

  depends_on 'python3' => :build

  no_source_build
end
