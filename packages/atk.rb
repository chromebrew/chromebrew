require 'package'

class Atk < Package
  description 'ATK provides the set of accessibility interfaces that are implemented by other tookits and applications'
  homepage 'https://developer.gnome.org/atk'
  version '2.26.1-1'
  source_url 'https://download.gnome.org/sources/atk/2.26/atk-2.26.1.tar.xz'
  source_sha256 'ef00ff6b83851dddc8db38b4d9faeffb99572ba150b0664ee02e46f015ea97cb'

  depends_on 'bison' => :build
  depends_on 'diffutils' => :build
  depends_on 'perl' => :build
  depends_on 'gobject_introspection'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
