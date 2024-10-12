require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version "0.12.1-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef78dfad2d7689f3da11cacedcab7bb2beae4a448e8ea47ede1759e4031f9da0',
     armv7l: 'ef78dfad2d7689f3da11cacedcab7bb2beae4a448e8ea47ede1759e4031f9da0',
       i686: '49d88b41984c5c171d5a3cab544d27a6e8124434a4f16891e59c0f25a5b1bc08',
     x86_64: 'a051a80059a6eb3ab001fe1e31f77f2b6d0ec3f889ec93cf0acccc52f6f06d94'
  })

  depends_on 'python3' => :build

  no_source_build
end
