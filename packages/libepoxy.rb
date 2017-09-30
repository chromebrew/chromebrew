require 'package'

class Libepoxy < Package
  description 'Epoxy is a library for handling OpenGL function pointer management for you'
  homepage 'https://github.com/anholt/libepoxy'
  version '1.4.3'
  source_url 'https://github.com/anholt/libepoxy/releases/download/1.4.3/libepoxy-1.4.3.tar.xz'
  source_sha256 '0b808a06c9685a62fca34b680abb8bc7fb2fda074478e329b063c1f872b826f6'

  depends_on 'mesa'
  depends_on 'python3'

  def self.build
    system "mkdir _build"
    Dir.chdir "_build" do
      system "../configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
      system "make"
    end
  end

  def self.install
    Dir.chdir "_build" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
