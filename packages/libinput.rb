require 'package'

class Libinput < Package
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput'
  version '1.10.2'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/libinput/libinput-1.10.2.tar.xz'
  source_sha256 '1509766d348efe8c6da4285efad3acff4a4c955defb43309e3e4851849197bb9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libinput-1.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libinput-1.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libinput-1.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libinput-1.10.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6c6f2b976bb841063b5411c5c7d8c3c1d76c3291f15559f20de6650b2d5ad3f',
     armv7l: 'c6c6f2b976bb841063b5411c5c7d8c3c1d76c3291f15559f20de6650b2d5ad3f',
       i686: 'a93a6da4b2f41ed20142acfa3515d016b185f8c628d14bc0e5fac77ee3b9ba77',
     x86_64: 'f1a15a0d4782ab26d86907f1228d1cc1c3ca1d67ba034a8a0458d9dc56d8ea11',
  })

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
