require 'package'

class Libinput < Package
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput'
  version '1.10.2'
  source_url 'https://www.freedesktop.org/software/libinput/libinput-1.10.2.tar.xz'
  source_sha256 '1509766d348efe8c6da4285efad3acff4a4c955defb43309e3e4851849197bb9'

  depends_on 'mtdev'
  depends_on 'libevdev'
  depends_on 'libwacom'
  depends_on 'libunwind'
  depends_on 'libcheck'    
  depends_on 'valgrind' => :build
  depends_on 'meson' => :build
    
  # If debug-gui feature is required, uncomment following lines and remove "-Ddebug-gui=false" to enable it
  #depends_on 'graphviz' => :build
  #depends_on 'gtk3' => :build

    
  def self.build
    system "meson \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                -Ddebug-gui=false \
                -Ddocumentation=false \
                _build"          
    system "ninja -v -C _build"   
  end

  def self.check
    system 'ninja -C _build test'
  end  
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
