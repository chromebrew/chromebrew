require 'buildsystems/autotools'

class Libxi < Autotools
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org/wiki/'
  version '1.8.2'
  license 'MIT and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.x.org/archive/individual/lib/libXi-#{version}.tar.gz"
  source_sha256 '5542daec66febfeb6f51d57abfa915826efe2e3af57534f4105b82240ea3188d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'faed3d1ad11fa264c71cce0d762e3941f29dd1d00620f5a45fdcc27419f54be5',
     armv7l: 'faed3d1ad11fa264c71cce0d762e3941f29dd1d00620f5a45fdcc27419f54be5',
     x86_64: 'a5cf0fb54f10f08851c562e2f9f60b5a87c3febee35c82cd9b53b267ebddfa2b'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' => :build
  depends_on 'xorg_proto' => :build
end
