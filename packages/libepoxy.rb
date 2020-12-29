require 'package'

class Libepoxy < Package
  description 'Epoxy is a library for handling OpenGL function pointer management for you'
  homepage 'https://github.com/anholt/libepoxy'
  version '1.5.5'
  compatibility 'all'
  source_url 'https://github.com/anholt/libepoxy/releases/download/1.5.5/libepoxy-1.5.5.tar.xz'
  source_sha256 '0b808a06c9685a62fca34b680abb8bc7fb2fda074478e329b063c1f872b826f6'

  depends_on 'mesa'
  depends_on 'python3'

  def self.build
    Dir.mkdir 'build'
    system "meson #{CREW_MESON_OPTIONS} build"
    system "ninja -C build"
  end

  def self.install
      system "meson install -C build"
  end
end
