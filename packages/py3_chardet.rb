require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "6.0.0.post1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '409f03867c9999f34e8a13dea3a90e0a9ba146ed3cfd5e3511e6e92c54eb0223',
     armv7l: '409f03867c9999f34e8a13dea3a90e0a9ba146ed3cfd5e3511e6e92c54eb0223',
       i686: 'c999371f63d7a7b6b0a0888eaaa325b7ce0dc688df84d64937debf320667f337',
     x86_64: 'bd030455c3f3b92c92e54583cc9c793cf289bce4c861198b063fb2bf628e38ac'
  })

  depends_on 'python3' => :build

  no_source_build
end
