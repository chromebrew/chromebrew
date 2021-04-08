require 'package'

class Intel_media_driver < Package
  description 'The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware.'
  homepage 'https://github.com/intel/media-driver'
  @_ver = '21.1.2' # 21.1.3 won't build as of 2021-04-07
  version "#{@_ver}"
  license 'BSD-3 and MIT'
  compatibility 'x86_64'

  case ARCH
  when 'x86_64'
    source_url "https://github.com/intel/media-driver/archive/intel-media-#{@_ver}.tar.gz"
    # 21.1.3 source_sha256 '219ce6b08a84bdce311160dc694d866249fd4e390391c2ac7be55f13a2fb928c'
    source_sha256 'f2374c29bc46dab73e0ab78c86620a2b644bd6989d33327fe3ba36c4b9d0f82f'

#    binary_url({
#      x86_64: 'NEW BINARY'
#    })
#    binary_sha256({
#      x86_64: 'NEW BINARY'
#    })

    depends_on 'gmmlib'
    depends_on 'libva'
    depends_on 'libpciaccess'
    depends_on 'libx11'
    depends_on 'libxext'
    depends_on 'samurai' => :build
    depends_on 'cmake' => :build

  end

  def self.preflight
    abort 'Not an Intel processor, aborting.'.lightred unless `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i.positive?
  end

  def self.patch
    @x_option = <<~X_OPTION_EOF
      --- a/media_driver/media_top_cmake.cmake
      +++ b/media_driver/media_top_cmake.cmake
      @@ -21,7 +21,12 @@
       project( media )

       find_package(PkgConfig)
      +if(NOT DEFINED USE_X11 OR USE_X11)
       find_package(X11)
      +endif(NOT DEFINED USE_X11 OR USE_X11)
      +if(USE_X11 AND NOT X11_FOUND)
      +    message(FATAL_ERROR "Usage of X11 is required by USE_X11 variable, but X11 package is not found")
      +endif(USE_X11 AND NOT X11_FOUND)

       bs_set_if_undefined(LIB_NAME iHD_drv_video)
    X_OPTION_EOF
    IO.write("x-option.patch", @x_option)

    system "patch -Np1 -i x-option.patch"
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
            cmake #{CREW_CMAKE_OPTIONS} ../ -G Ninja \
              -DBUILD_SHARED_LIBS=ON \
              -DMEDIA_BUILD_FATAL_WARNINGS=OFF \
              -DPLATFORM=linux \
              -DLATEST_CPP_NEEDED=ON \
              -DUSE_X11=ON \
              -Wno-dev"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # intel_media_driver configuration
      export LIBVA_DRIVER_NAME=iHD
      export export LIBVA_DRIVERS_PATH=#{CREW_LIB_PREFIX}
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/intel_media_driver", @env)
  end
end
