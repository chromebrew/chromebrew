require 'buildsystems/autotools'

class Libfilezilla < Autotools
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.44.0'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.44.0.tar.xz'
  source_sha256 '2a8f57a06b52f6413b47d6a5dfbe7e9e31c84cc0784076f2f7e395232b0bd461'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.44.0_armv7l/libfilezilla-0.44.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.44.0_armv7l/libfilezilla-0.44.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.44.0_x86_64/libfilezilla-0.44.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4539d3cf4220ea552e26d3fc7808c686849472c13d07b8f97f5ae0a2fa86d580',
     armv7l: '4539d3cf4220ea552e26d3fc7808c686849472c13d07b8f97f5ae0a2fa86d580',
     x86_64: '2d9ef1bca2af46802ef74fbb8962d54e931ba8c3e9543451c28993349f0ba7ad'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'nettle' # R
  depends_on 'openmp' => :build
  depends_on 'p11kit' => :build
end
