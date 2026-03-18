require 'buildsystems/meson'

class Libfontenc < Meson
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.1.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libfontenc.git'
  git_hashtag "libfontenc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e5adf56b3720b507dc715b20646f32dfe47cebfe6107a143e1fe5add3c6d426b',
     armv7l: 'e5adf56b3720b507dc715b20646f32dfe47cebfe6107a143e1fe5add3c6d426b',
       i686: '55476a9fea8f3a75351a4dff6906b251195e7b195056d656d14dff78c388aa40',
     x86_64: '84f7004da7e7f4da177b01ebbce66b7e2d3b0733c428348ecb362b1ff9370faa'
  })

  depends_on 'glibc' # R
  depends_on 'xorg_proto' => :build
  depends_on 'zlib' # R

  meson_options "-Dwith-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
end
