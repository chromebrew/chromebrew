# CMake builds are not supported for i686.
require 'buildsystems/autotools'

class Libunwind < Autotools
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.8.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libunwind/libunwind.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d1ffede13101af1422135afd10687757c0f13ec66255470a9531f7470136ca4',
     armv7l: '4d1ffede13101af1422135afd10687757c0f13ec66255470a9531f7470136ca4',
       i686: '1c1c3919cca46f61d71d46c6f3182e01461c6fe19024b69603dcfa02061c546c',
     x86_64: 'f1dbd4e2888576534d8f1fa7d20dc6f7a4d7c408265bc5def3e98ace3187197e'
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
