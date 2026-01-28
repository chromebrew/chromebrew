require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version "1.0.4-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6410f2d7811c0807621928c948520e6c81d73ef5de52202f7f237e716cf04001',
     armv7l: '6410f2d7811c0807621928c948520e6c81d73ef5de52202f7f237e716cf04001',
       i686: 'd22615714963bdf3b8e62045d6f042057eeefbafea76f223773508b30d2f1235',
     x86_64: '0b28f9322867e92135bed61716d487d6d0c1ad452cf046ed5b82fbe62c96a4dc'
  })

  depends_on 'python3' => :build

  no_source_build
end
