require 'buildsystems/autotools'

class Libffi < Autotools
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.4.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3019c6b5747d07c5db6a45e697df097264076d0f7f7562c031cbe6f78b6f9c0f',
     armv7l: '3019c6b5747d07c5db6a45e697df097264076d0f7f7562c031cbe6f78b6f9c0f',
       i686: '42d4375e7977b761d65df125e4cb22c910e6bbe9f15f1770126e92414d56f46f',
     x86_64: '248bdaa9c63f2a2e6bde72294a7170329de410e57066f2b47c8a3c44b36c62cf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # run_tests         # DejaGNU required
end
