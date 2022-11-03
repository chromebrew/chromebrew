require 'package'

class Intel_media_driver < Package
  description 'The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware.'
  homepage 'https://github.com/intel/media-driver'
  @_ver = '22.6.0-c7132d8'
  version @_ver
  license 'BSD-3, and MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/media-driver.git'
  git_hashtag 'c7132d869bed4d9748b789ed4aeb06cc49a311d5'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/intel_media_driver/22.6.0-c7132d8_x86_64/intel_media_driver-22.6.0-c7132d8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'c8fbadb3eb1e5bec3ff67430d3de69037913e3b2605b02b985b73a1d43c36f17'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'gmmlib'
  depends_on 'libva'

  #  def self.preflight
  #    abort 'Not an Intel processor, aborting.'.lightred unless CREW_IS_INTEL
  #  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS.sub('-pipe', '-pipe -Wno-error')} \
      -DMEDIA_BUILD_FATAL_WARNINGS=OFF \
      ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~CONFIG_EOF
      # intel_media_driver configuration
      export LIBVA_DRIVER_NAME=iHD
    CONFIG_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/intel_media_driver", @env)
  end
end
