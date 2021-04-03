require 'package'

class Intel_media_driver < Package
  description 'The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware.'
  homepage 'https://github.com/intel/media-driver'
  @_ver = '21.1.3'
  version "#{@_ver}"
  license 'BSD-3, and MIT'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url "https://github.com/intel/media-driver/archive/intel-media-#{@_ver}.tar.gz"
    source_sha256 '219ce6b08a84bdce311160dc694d866249fd4e390391c2ac7be55f13a2fb928c'

#    binary_url({
#      x86_64: 'NEW BINARY'
#    })
#    binary_sha256({
#      x86_64: 'NEW BINARY'
#    })

    depends_on 'gmmlib'
    depends_on 'libva'
    depends_on 'samurai' => :build
    depends_on 'cmake' => :build
  end

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
            LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
            cmake #{CREW_CMAKE_OPTIONS} ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # intel_media_driver configuration
      export LIBVA_DRIVER_NAME=iHD
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/intel_media_driver", @env)
  end
end
