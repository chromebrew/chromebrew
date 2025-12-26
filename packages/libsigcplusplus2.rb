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
    aarch64: 'd33680372487ef87e897842d96746329b58d26f9b28bd4e7ab1ac2eb12fd2281',
     armv7l: 'd33680372487ef87e897842d96746329b58d26f9b28bd4e7ab1ac2eb12fd2281',
       i686: '9253e0064a20cb48957c452b1edf13e76a320a941582f4f1b6d47bd018d81628',
     x86_64: '3275a49256cb3680887df6918929f92e6e9491e084061a9e3d7430429b970eb4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'mm_common' => :build

  # TODO: We can actually track upstream updates, we just need to only check releases in the 2.x series.
  no_upstream_update

  meson_options '-Dbuild-deprecated-api=true -Dbuild-examples=false -Dbuild-documentation=false'
end
