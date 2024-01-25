require 'buildsystems/python'

class Py3_pyicu < Python
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  @_ver = '2.11'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.pyicu.org/main/pyicu.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd243b8816553c5445c02292bc1f54f3cc4cea42c44d8718f6ec52f1ceeacd147',
     armv7l: 'd243b8816553c5445c02292bc1f54f3cc4cea42c44d8718f6ec52f1ceeacd147',
       i686: '7823270efeb41822ba1b393f2ff01c05fcd0c2347993125cfc5afb1e76f9b978',
     x86_64: 'd9e0708f07bebe04073a36ac927243a79a9bdd2cd76aba58e5564302b34cc75e'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
end
