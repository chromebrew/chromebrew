require 'buildsystems/cmake'

class Openvr < CMake
  description 'OpenVR is an API and runtime that allows access to VR hardware from multiple vendors without requiring that applications have specific knowledge of the hardware they are targeting.'
  homepage 'https://github.com/ValveSoftware/openvr'
  version '2.15.6'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/ValveSoftware/openvr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84da36d1e2bb01a934a17734a6a703c6ccc73e3e33a971c3145e0423b3e4eab7',
     armv7l: '84da36d1e2bb01a934a17734a6a703c6ccc73e3e33a971c3145e0423b3e4eab7',
       i686: 'fc3c1a4061b7a68af70f60568d7fdc0b8bec04bc56413e96e40456529f810ddd',
     x86_64: 'd2185584f81cb00209fa41ebb810e7ef23c3810851ebb16e29df48835f28d384'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DBUILD_SHARED=ON'

  cmake_install_extras do
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX if ARCH.eql?('x86_64')
  end
end
