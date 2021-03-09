require 'package'

class Intel_media_driver < Package
  description 'The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware.'
  homepage 'https://github.com/intel/media-driver'
  compatibility 'i686, x86_64'
  @_ver = '20.4.5'
  version @_ver
  source_url "https://github.com/intel/media-driver/archive/intel-media-#{@_ver}.tar.gz"
  source_sha256 '3d856a963127ddd6690fc6dac521d7674947675d5f20452f1e6f45c0fc83f9e6'
  
  depends_on 'libva'
  depends_on 'gmmlib'
  
  def self.preflight
    abort 'Not an Intel processor, aborting.'.lightred unless `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i > 0
  end
  
  def self.patch
    system "find . -type f -exec sed -e 's,LD_LIBRARY_PATH=,LD_LIBRARY_PATH=#{CREW_LIB_PREFIX}:,g' \
            -e 's,-fstack-protector,-flto=auto,g' -i {} +"
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
