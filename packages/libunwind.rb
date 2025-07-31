# CMake builds are not supported for i686.
require 'buildsystems/autotools'

class Libunwind < Autotools
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.8.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libunwind/libunwind.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '055e943710657c9ab452eac188e876f074228f1f212711c6e20570fd07c74dc9',
     armv7l: '055e943710657c9ab452eac188e876f074228f1f212711c6e20570fd07c74dc9',
       i686: '603a322abd5a8815f28f8f3e7774bab70119ed3396a81378e3bbc0dea6d52a1a',
     x86_64: 'd075e57a6088eb14daf353bc716125a3b25dc7d14465ca5615a96b8bb17b5fbc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

  autotools_configure_options '--enable-ptrace'

  def self.patch
    patches = [
      # Fix GCC 15 compat.
      ['https://github.com/libunwind/libunwind/pull/831.patch', '4562c231f1051bd327cf27b6940445e5c0d83e5d8427a6ca36c9f0853b3e4a6d']
    ]
    ConvenienceFunctions.patch(patches)
  end
end
