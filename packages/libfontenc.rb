require 'buildsystems/meson'

class Libfontenc < Meson
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.1.8-dcdbcce'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libfontenc.git'
  git_hashtag 'dcdbcce903ee49200040c0da092b45253c20c6df'
  # git_hashtag "libfontenc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd70cccae338c12cd80cb891b8f1694a70cdba76da9d077a39e3eea271405fd1a',
     armv7l: 'd70cccae338c12cd80cb891b8f1694a70cdba76da9d077a39e3eea271405fd1a',
       i686: '8ad3c20ea1adfe41284ae9f87dc3120bdae83538213da0fbb54e5334940dffc2',
     x86_64: '419779b15ee846873388eee1ab46cbb8fc31dab220443043f15abaa59698be31'
  })

  depends_on 'xorg_proto' => :build
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  meson_options "-Dwith-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
end
