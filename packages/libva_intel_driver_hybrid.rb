require 'package'

class Libva_intel_driver_hybrid < Package
  description 'VA-API implementation for Intel G45 and HD Graphics family'
  version '2.4.1'
  compatibility 'i686 x86_64'
  if ARCH == 'i686', 'x86_64'
    source_url 'https://github.com/intel/intel-vaapi-driver/archive/2.4.1.tar.gz'
    source_sha256 '03cd7e16acc94f828b6e7f3087863d8ca06e99ffa3385588005b1984bdd56157'
    depends_on 'igt_gpu_tools'
  end

  binary_url({
    i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva_intel_driver_hybrid-2.4.1-chromeos-i686.tar.xz',
  x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva_intel_driver_hybrid-2.4.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: '44544381f5d72ee7a564d7d44a9857e42413f1337dc3f1e8e41d4d785644c981',
  x86_64: '1573c67aeab4b6919a8979688962d4f2bbab0da8fd8497b9970424c10fe25aae'
  })

  def self.patch
    # Only relevant if intel-gpu-tools is installed,
    # since then the shaders will be recompiled
    system "sed -i '1s/python\$/&2/' src/shaders/gpp.py"
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
            -Denable_hybrid_codec=true builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    @_str = 'export LIBVA_DRIVER_NAME=i965'
    if `grep -c '#{@_str}' #{HOME}/.bashrc`.to_i.zero?
      puts 'Performing env-setup...'
      system "echo '#{@_str}' >> #{HOME}/.bashrc"
      puts
      puts 'To complete the installation, execute the following:'.lightblue
      puts 'source ~/.bashrc'.lightblue
      puts
    end
  end
end
