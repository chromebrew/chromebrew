require 'buildsystems/autotools'

class Libxext < Autotools
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.3.6'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/lib/libXext-1.3.6.tar.xz'
  source_sha256 'edb59fa23994e405fdc5b400afdf5820ae6160b94f35e3dc3da4457a16e89753'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ed26f102a7fefc71259c3849ba8549d6cc11b6af74a73bafe333c8ee880120b',
     armv7l: '5ed26f102a7fefc71259c3849ba8549d6cc11b6af74a73bafe333c8ee880120b',
     x86_64: '0d9a949182965e1eb29f6c27c20b74dd30adef38cad9f169d09e662730777ae0'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'llvm18_lib' => :build
  depends_on 'xmlto' => :build
  depends_on 'xorg_proto' # R

  run_tests
end
