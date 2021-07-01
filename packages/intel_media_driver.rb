require 'package'

class Intel_media_driver < Package
  description 'The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware.'
  homepage 'https://github.com/intel/media-driver'
  @_ver = '21.2.3'
  version @_ver
  license 'BSD-3, and MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/media-driver.git'
  git_hashtag "intel-media-#{@_ver}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/intel_media_driver/21.2.3_x86_64/intel_media_driver-21.2.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: '9bf56121437ac94df50cd1e9e6d2ac74802d0b72d901a0019c47d6ef68af353a'
  })

  depends_on 'gmmlib'
  depends_on 'libva'

  def self.preflight
    abort 'Not an Intel processor, aborting.'.lightred unless `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i.positive?
  end

  def self.patch
    system "find . -type f -exec sed -e 's,LD_LIBRARY_PATH=,LD_LIBRARY_PATH=#{CREW_LIB_PREFIX}:,g' \
            -e 's,-fstack-protector-all,-fno-stack-protector,g' \
            -e 's,-Werror=return-type,-Werror=return-type -Wno-error=maybe-uninitialized,g' \
            -e 's,-fstack-protector,-fno-stack-protector,g' -i {} +"
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS.sub('-pipe', '-pipe -Wno-error')} ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # intel_media_driver configuration
      export LIBVA_DRIVER_NAME=iHD
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/intel_media_driver", @env)
  end
end
