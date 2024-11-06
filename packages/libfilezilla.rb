require 'buildsystems/autotools'

class Libfilezilla < Autotools
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.48.1'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  # NOTE: This may generate a 403 forbidden error. To receive a new source url,
  # download from here: https://lib.filezilla-project.org/download.php?show_all=1.
  source_url "https://dl4.cdn.filezilla-project.org/libfilezilla/libfilezilla-#{version}.tar.xz?h=pN1wsJgaHaL--GZACTd24g&x=1726372521"
  source_sha256 '4eea8abd456096625893b707e8db6c949e6f0466136c51c0b8ce58b5f8ef1e43'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1009853909be5734aab4fc20f4f3938e4c35120fbc3f7860078f6d6a135662c2',
     armv7l: '1009853909be5734aab4fc20f4f3938e4c35120fbc3f7860078f6d6a135662c2',
     x86_64: '045d8eb31c060ea8f21819a8c4a49b9e14f8425a73c20f5ba59cb749fc07b8ce'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'nettle' # R
  depends_on 'openmp' => :build
  depends_on 'p11kit' => :build
end
