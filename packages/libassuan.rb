require 'buildsystems/autotools'

class Libassuan < Autotools
  description 'Libassuan is a small library implementing the so-called Assuan protocol.'
  homepage 'https://www.gnupg.org/related_software/libassuan/index.html'
  version '3.0.2'
  license 'GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-#{version}.tar.bz2"
  source_sha256 'c8f0f42e6103dea4b1a6a483cb556654e97302c7465308f58363778f95f194b1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1032069449ba6da10e82fef9734a2392a7e4fe7e88062bc84e9a39edd945a14',
     armv7l: 'f1032069449ba6da10e82fef9734a2392a7e4fe7e88062bc84e9a39edd945a14',
       i686: 'dff73e4be4a368f63d2333551600101e170c38ed4dade61c2ee077b7ec70c997',
     x86_64: '1c7f8129f9e066c9881dd4d75b83d9db0a266769c814de61394d676254e4459f'
  })

  depends_on 'glibc' # R
  depends_on 'libgpg_error' # R

  run_tests
end
