require 'buildsystems/cmake'

class Onevpl < CMake
  description 'oneAPI Video Processing Library'
  homepage 'https://www.intel.com/content/www/us/en/developer/tools/vpl/overview.html'
  version '2023.4.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/oneapi-src/oneVPL.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '23a79ff8af0ce111b4bff1839d64b08835d599a0c7f23afb63dcdf6f4b909643'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'intel_media_sdk' => :library
  depends_on 'libdrm' => :library
  depends_on 'libva' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :library
  depends_on 'wayland' => :library
  depends_on 'wayland_protocols' => :build

  cmake_options '-DBUILD_TESTS=OFF -DINSTALL_EXAMPLE_CODE=OFF'

  def self.patch
    # Fix error: ‘uint64_t’ was not declared in this scope
    system "sed -i '11i#include <cstdint>' tools/legacy/sample_vpp/src/sample_vpp_frc_adv.cpp"
  end
end
