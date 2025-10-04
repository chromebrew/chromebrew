require 'buildsystems/meson'

class Libfontenc < Meson
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.1.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libfontenc.git'
  git_hashtag "libfontenc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d2dee2568b7a2389cff4435c26653fe56c8b3bda1132ec74215ed87ca8eb287',
     armv7l: '8d2dee2568b7a2389cff4435c26653fe56c8b3bda1132ec74215ed87ca8eb287',
       i686: '20d2b4358c6b10ac9f215919ec0b57691565d7dd1e8883d32397ed5b1d773b32',
     x86_64: '4331cdbb4108722b6fc8d05249cdba21b67e917270ccba8b03b17808176dc30f'
  })

  depends_on 'xorg_proto' => :build
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  meson_options "-Dwith-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
end
