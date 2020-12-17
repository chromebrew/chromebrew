require 'package'

class Graphene < Package
  description 'A thin layer of graphic data types'
  homepage 'https://github.com/ebassi/graphene'
  version '1.10.2'
  compatibility 'all'
  source_url 'https://github.com/ebassi/graphene/archive/1.10.2.tar.gz'
  source_sha256 '87c682291fa38a131aaf9aaee17d053d7bd4ea5309d305a356619c95784b9b4d'


  depends_on 'gobject_introspection' => :build

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson #{CREW_MESON_OPTIONS} \
      -Darm_neon=false \
      -Dinstalled_tests=false \
      -Dtests=false \
      _build"  
    system "meson configure _build"         
    system "ninja -v -C _build"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end 
end
