require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.31-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af955b189f9bd3a85a0fbb1c234081344ce4db4d5e3b394b87b8d8d1575fc2ef',
     armv7l: 'af955b189f9bd3a85a0fbb1c234081344ce4db4d5e3b394b87b8d8d1575fc2ef',
       i686: 'a558f157123d469f49020ffb405a63124e3af25bfbe1e187e803fc68402aa0ad',
     x86_64: '32539e2ebe04a3000b1a1c25b237c7343a70cd92cc5886a789fb7ff8e9070739'
  })

  depends_on 'python3' => :logical

  no_source_build
end
