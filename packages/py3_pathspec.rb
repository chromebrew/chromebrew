require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version "#{@_ver}-py3.12"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3169f3b108464982d40355877bb4768a19d46abd1ca6a311bd011a382dad01f4',
     armv7l: '3169f3b108464982d40355877bb4768a19d46abd1ca6a311bd011a382dad01f4',
       i686: 'aac2999e6ff5d2f56cd41f2e9e2e58120b737cbddcf178d8b962fb4fcd6046c2',
     x86_64: 'c1695e925dac96f847a4cb243c516d9df27135a927a3927217828fd4a6b4a341'
  })

  depends_on 'python3' => :build
end
