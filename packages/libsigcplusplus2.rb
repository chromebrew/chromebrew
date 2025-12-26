require 'buildsystems/meson'

class Libsigcplusplus2 < Meson
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'https://github.com/libsigcplusplus/libsigcplusplus/'
  version '2.12.1'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/libsigcplusplus/libsigcplusplus.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8aa5460bb1d220dc2410c0288b0512c6e41b17cdc06495b1b5360dc78b967218',
     armv7l: '8aa5460bb1d220dc2410c0288b0512c6e41b17cdc06495b1b5360dc78b967218',
       i686: 'e8f554091382e299fa718ea96937636ec225ad5274bc71e6aa3888de7a58d81f',
     x86_64: '010db32ea5deb55ba8fb4126c60e725b231d6ec6c68454407b26a5204faf5807'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'mm_common' => :build

  # TODO: We can actually track upstream updates, we just need to only check releases in the 2.x series.
  no_upstream_update

  meson_options '-Dbuild-deprecated-api=true -Dbuild-examples=false -Dbuild-documentation=false'
end
