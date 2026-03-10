require 'buildsystems/cmake'

class Intel_media_driver < CMake
  description 'The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware.'
  homepage 'https://github.com/intel/media-driver'
  version '25.4.6'
  license 'BSD-3, and MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/media-driver.git'
  git_hashtag "intel-media-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '00b1a76c27572a710ee2f20bd073c9250493be1661f75dd781ef05c14cc929dc'
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
