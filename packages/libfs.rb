require 'buildsystems/autotools'

class Libfs < Autotools
  description 'X.org library interface to the X Font Server.'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libfs'
  license 'MIT'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libfs.git'
  git_hashtag "libFS-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f554a615f2ea5b403d77be6edf391ff7bfbf7bc0bca7579d80cfaf2fe169353a',
     armv7l: 'f554a615f2ea5b403d77be6edf391ff7bfbf7bc0bca7579d80cfaf2fe169353a',
       i686: 'a8219348dea1bd82dcc9d4a6696fa3aef747fc14318daed6813217b74350a874',
     x86_64: '35677e274ea6880e98cf2d613c866bfdb00d40ceda3ebfcf18149df01c05112a'
  })

  depends_on 'glibc' # R
  depends_on 'libxtrans'
  depends_on 'xorg_proto'
end
