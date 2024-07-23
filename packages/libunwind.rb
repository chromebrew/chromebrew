# CMake builds are not supported for i686.
require 'buildsystems/autotools'

class Libunwind < Autotools
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.8.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libunwind/libunwind.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a0a1ba55a3a5f646afc2d85f6974048f864f63ca27f3ce0f625bd356ded873c',
     armv7l: '6a0a1ba55a3a5f646afc2d85f6974048f864f63ca27f3ce0f625bd356ded873c',
       i686: '4be44a4f45332428aef90caa9894a290b7c2aede241554f010fb1da415d9f4a8',
     x86_64: '2ba5c2f4af19dc104f7dc64471935ddc03672dbf31874bfd3d8469ff6203178a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  configure_options '--enable-ptrace'
end
