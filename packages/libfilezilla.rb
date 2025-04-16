require 'buildsystems/autotools'

class Libfilezilla < Autotools
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.50.0'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  # NOTE: This may generate a 403 forbidden error. To receive a new source url,
  # download from here: https://lib.filezilla-project.org/download.php?show_all=1.
  source_url 'https://dl4.cdn.filezilla-project.org/libfilezilla/libfilezilla-0.50.0.tar.xz?h=d6jb0-dbxaplBx1p29Mg3A&x=1744782812'
  source_sha256 '6d99be1b5a47fbc68aaab83bcc483d84ad170a672eb648a226bf792356455177'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec3d8ff0fc83851567cb3d62bfbb818e75d7ad24fa07b77384bdae481fa13bba',
     armv7l: 'ec3d8ff0fc83851567cb3d62bfbb818e75d7ad24fa07b77384bdae481fa13bba',
     x86_64: '876843dbc83386089025347d8a65437c796eb04d7fafc83064c2d8cd0683126f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'nettle' # R
  depends_on 'openmp' => :build
  depends_on 'p11kit' => :build
end
