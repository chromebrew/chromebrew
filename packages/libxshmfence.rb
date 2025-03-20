require 'buildsystems/autotools'

class Libxshmfence < Autotools
  description 'A library that exposes a event API on top of Linux futexes'
  homepage 'http://t2sde.org/packages/libxshmfence.html'
  version '1.3.3'
  license 'HPND'
  compatibility 'all'
  source_url "https://xorg.freedesktop.org/releases/individual/lib/libxshmfence-#{version}.tar.xz"
  source_sha256 '1129f95147f7bfe6052988a087f1b7cb7122283d2c47a7dbf7135ce0df69b4f8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02f4ab456e7cb76d57ce68cac91d1ff3e94b47b0590602537bee71fb3638e90d',
     armv7l: '02f4ab456e7cb76d57ce68cac91d1ff3e94b47b0590602537bee71fb3638e90d',
       i686: 'd5f1bad7c9f6ed83b3045f261577d9de9b427eb94d6fa987cc0788ebe9d5becb',
     x86_64: 'cdf155dbc90266359e6542292d198630a598bc0c5867ce1e6c3590eef674b1ed'
  })

  depends_on 'glibc' # R
  depends_on 'xorg_proto' => :build
end
