require 'buildsystems/autotools'

class Libxdmcp < Autotools
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libxdmcp'
  version '1.1.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxdmcp.git'
  git_hashtag "libXdmcp-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d48ce878c0b396e1b31800e3861c2081b5e29a26d4e948ac6c3dbcb9b86d8ec',
     armv7l: '7d48ce878c0b396e1b31800e3861c2081b5e29a26d4e948ac6c3dbcb9b86d8ec',
       i686: '2b4fe67950321efca05634b09e694a5482fa8ecfe41ee58e693cc0eba38beaba',
     x86_64: 'e8e3832fa1f024a3546e435f028ca6c47894a32705e56fa11e2b29467ea4cd9e'
  })

  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'xorg_macros' => :build
  depends_on 'xorg_proto'

  run_tests
end
