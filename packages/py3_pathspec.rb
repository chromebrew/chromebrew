require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version "1.1.0-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8e13d613c5480f13c4642d1fa501a3e0f21a92a13525d9b5601a3de201ed617',
     armv7l: 'a8e13d613c5480f13c4642d1fa501a3e0f21a92a13525d9b5601a3de201ed617',
       i686: '5a808fed39208a89e461fd673ae1773f34903f3b9a334f4def41a4fed5bdbac4',
     x86_64: 'ff6386a5058c5b019799798d78e743cc7c4352ae7772f39257868348884f4227'
  })

  depends_on 'python3' => :logical

  no_source_build
end
