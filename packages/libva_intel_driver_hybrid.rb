# Adapted from Arch Linux libva-intel-driver-hybrid PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libva-intel-driver-hybrid

require 'package'

class Libva_intel_driver_hybrid < Package
  description 'VA-API implementation for Intel G45 and HD Graphics family'
  version '2.4.1'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/intel-vaapi-driver/archive/2.4.1.tar.gz'
  source_sha256 '03cd7e16acc94f828b6e7f3087863d8ca06e99ffa3385588005b1984bdd56157'


  depends_on 'igt_gpu_tools'
  
  def self.patch
    system "sed -i '1s/python\$/&2/' src/shaders/gpp.py"
  end
  
  def self.build
    # Only relevant if intel-gpu-tools is installed,
    # since then the shaders will be recompiled
    system "sed -i '1s/python\$/&2/' src/shaders/gpp.py"
    system "meson #{CREW_MESON_LTO_OPTIONS} \
            -Denable_hybrid_codec=true builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
  
  def self.postinstall
    @_str = 'export LIBVA_DRIVER_NAME=i965'
    if `grep -c '#{@_str}' #{HOME}/.bashrc`.to_i == 0    
      puts 'Performing env-setup...'
      system "echo '#{@_str}' >> #{HOME}/.bashrc"
      puts
      puts 'To complete the installation, execute the following:'.lightblue
      puts 'source ~/.bashrc'.lightblue
      puts
    end
  end
end
