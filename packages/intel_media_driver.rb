require 'package'

class Intel_media_driver < Package
  description 'The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware.'
  homepage 'https://github.com/intel/media-driver'
  @_ver = '20.4.5'
  version @_ver
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url "https://github.com/intel/media-driver/archive/intel-media-#{@_ver}.tar.gz"
    source_sha256 '3d856a963127ddd6690fc6dac521d7674947675d5f20452f1e6f45c0fc83f9e6'
    depends_on 'gmmlib'
    depends_on 'libva'
  end

  binary_url({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/intel_media_driver-20.4.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    x86_64: '0710ad9dd76b97b62849cfe6179dae0e884e56c475332b03f889d5eaa121ffff'
  })


  def self.preflight
    abort 'Not an Intel processor, aborting.'.lightred unless `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i.positive?
  end

  def self.patch
    system "find . -type f -exec sed -e 's,LD_LIBRARY_PATH=,LD_LIBRARY_PATH=#{CREW_LIB_PREFIX}:,g' \
            -e 's,-fstack-protector-all,-fno-stack-protector,g' \
            -e 's,-fstack-protector,-fno-stack-protector,g' -i {} +"
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
            CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
            LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
            cmake #{CREW_CMAKE_OPTIONS} ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    @_str = 'export LIBVA_DRIVER_NAME=iHD'
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
