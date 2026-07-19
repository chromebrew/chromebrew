require 'buildsystems/cmake'

class Libaec < CMake
  description 'Adaptive Entropy Coding library'
  homepage 'https://gitlab.dkrz.de/dkrz-sw/libaec'
  version '1.1.7'
  license 'Copyright 2008 Simon Tatham. All rights reserved.'
  compatibility 'all'
  source_url 'https://gitlab.dkrz.de/dkrz-sw/libaec.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac98eef52bce6f11efe1dbc938123c4160d1e679a540992d2551f39f20c40a5e',
     armv7l: 'ac98eef52bce6f11efe1dbc938123c4160d1e679a540992d2551f39f20c40a5e',
       i686: 'a20b149da2e7e44d415ee762411c9165b6cbd4176b4110808d6dc19be11f5329',
     x86_64: 'f944d9a12aed92eec08dba4fa02f2f7fe76f0d7c02ec822a32867a163025996e'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
