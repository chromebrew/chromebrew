require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.26.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71a3e7fee6c09cc699bbfbc33a184801e6c74161b402a9ac27f6366ff01865c4',
     armv7l: '71a3e7fee6c09cc699bbfbc33a184801e6c74161b402a9ac27f6366ff01865c4',
       i686: '0d4bd898fe0ca2f4ea4249a64a4baabd03e83ddf79b49d8d32e9b90a8f1253ed',
     x86_64: '58dc9db73b1cae5dc507968e7118c4083a6b5514f2db60a568f43796a5740f5c'
  })

  depends_on 'python3' => :build

  no_source_build
end
