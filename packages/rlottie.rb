require 'package'

class Rlottie < Package
  description 'rlottie is a platform independent standalone c++ library for rendering vector based animations and art in realtime.'
  homepage 'https://github.com/Samsung/rlottie'
  version '0.2'
  compatibility 'all'
  source_url 'https://github.com/Samsung/rlottie/archive/v0.2.tar.gz'
  source_sha256 '030ccbc270f144b4f3519fb3b86e20dd79fb48d5d55e57f950f12bab9b65216a'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system "meson configure builddir"
    system "meson compile -C builddir"
  end

  def self.install
    system "env DESTDIR=#{CREW_DEST_DIR} meson install -C builddir"
  end
end
