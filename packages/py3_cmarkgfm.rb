require 'buildsystems/pip'

class Py3_cmarkgfm < Pip
  description 'Python bindings to GitHub\'s cmark.'
  homepage 'https://github.com/theacodes/cmarkgfm'
  version "2024.1.14-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73e816ed447107b4f109a4a5a543771fb172f33397837df48fe193a80e39faae',
     armv7l: '73e816ed447107b4f109a4a5a543771fb172f33397837df48fe193a80e39faae',
       i686: '881fe44a87de8c2aedfc2b2c542114772419abc54f7889c54d614a6dd7a1f63d',
     x86_64: 'c912f03785dba5b2f548ea91778cf128065d7a90f3ac63447da36514af7cf18b'
  })

  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' => :build

  no_source_build
end
