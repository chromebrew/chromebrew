require 'buildsystems/autotools'

class Libfilezilla < Autotools
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.49.0'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  # NOTE: This may generate a 403 forbidden error. To receive a new source url,
  # download from here: https://lib.filezilla-project.org/download.php?show_all=1.
  source_url 'https://dl3.cdn.filezilla-project.org/libfilezilla/libfilezilla-0.49.0.tar.xz?h=G3r8CiGNYTY6d1KKq3SVOg&x=1740339657'
  source_sha256 '4eea8abd456096625893b707e8db6c949e6f0466136c51c0b8ce58b5f8ef1e43'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7d0bfbe700515e0ffa62766800881d34fc1fa61bf71845f2a1435e6b23a4cd7',
     armv7l: 'b7d0bfbe700515e0ffa62766800881d34fc1fa61bf71845f2a1435e6b23a4cd7',
     x86_64: 'b7a1b3760a331fc3254c5378727f112ce0f943987ed3f41932d2d527aaefbbba'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'nettle' # R
  depends_on 'openmp' => :build
  depends_on 'p11kit' => :build
end
