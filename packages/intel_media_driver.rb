require 'buildsystems/cmake'

class Intel_media_driver < CMake
  description 'The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware.'
  homepage 'https://github.com/intel/media-driver'
  version '25.2.6'
  license 'BSD-3, and MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/media-driver.git'
  git_hashtag "intel-media-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '6671eed059ffd7256f9df5d11ee95aaefdbd26a801e8906105942da83a3730ce'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmmlib' # R
  depends_on 'libva' # R

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5.0 -DINSTALL_DRIVER_SYSCONF=OFF -DMEDIA_BUILD_FATAL_WARNINGS=OFF'

  cmake_build_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"

    File.write "#{CREW_DEST_PREFIX}/etc/env.d/intel_media_driver", <<~CONFIG_EOF
      # intel_media_driver configuration
      export LIBVA_DRIVER_NAME=iHD
    CONFIG_EOF
  end
end
