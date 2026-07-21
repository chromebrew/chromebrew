require 'buildsystems/meson'

class Dav1d < Meson
  description 'dav1d is a new AV1 cross-platform decoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.5.4'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee952aa8dcbad8dac19aa271a1bbbcf668ce5f34bbfa644c6c0c5ebd9847a371',
     armv7l: 'ee952aa8dcbad8dac19aa271a1bbbcf668ce5f34bbfa644c6c0c5ebd9847a371',
       i686: 'c168826efbecb20fb3720c0affccf022a54a62896052c019a1e8d104ce81280f',
     x86_64: '5044e342960e619bb73de7006be272f3376cc6b03d6f8e3684997fc45493c893'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nasm' => :build
end
