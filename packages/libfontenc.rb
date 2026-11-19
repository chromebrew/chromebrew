require 'buildsystems/meson'

class Libfontenc < Meson
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.1.10'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libfontenc.git'
  git_hashtag "libfontenc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d94e8bf017c6c4b3e4fb018dc51b6f8002816746591a655fc009569cd166efc',
     armv7l: '4d94e8bf017c6c4b3e4fb018dc51b6f8002816746591a655fc009569cd166efc',
       i686: '0ba9b55036265a5dbdb3f64522871a434758aeebb8385954e5fd8c7057be3207',
     x86_64: 'a215f9431d77cbb911debd16bb2de9a31e46766c879a5c313450853bcd1db4c2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'xorg_proto' => :build
  depends_on 'zlib' => :library

  meson_options "-Dwith-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
end
