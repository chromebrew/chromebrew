require 'package'

class Libepoxy < Package
  description 'Epoxy is a library for handling OpenGL function pointer management for you'
  homepage 'https://github.com/anholt/libepoxy'
  version '1.5.5'
  compatibility 'all'
  source_url 'https://github.com/anholt/libepoxy/releases/download/1.5.5/libepoxy-1.5.5.tar.xz'
  source_sha256 '261663db21bcc1cc232b07ea683252ee6992982276536924271535875f5b0556'

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
