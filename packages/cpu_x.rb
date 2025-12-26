require 'buildsystems/cmake'

class Cpu_x < CMake
  description 'CPU-X is a Free software that gathers information on CPU, motherboard and more.'
  homepage 'https://thetumultuousunicornofdarkness.github.io/CPU-X/'
  version '5.4.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/TheTumultuousUnicornOfDarkness/CPU-X.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0504d4279c7cca0516efd75428e7b300e73ee8b3979d18b58b55407f4f83ca39',
     armv7l: '0504d4279c7cca0516efd75428e7b300e73ee8b3979d18b58b55407f4f83ca39',
     x86_64: 'f44e9ba368c56eb391f02bc2425a18d3b238297656b9a423d2c29b7b87fdaa7e'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'atkmm16' # R
  depends_on 'cairo' # R
  depends_on 'cairomm_1_0' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'gtk3' # R
  depends_on 'gtkmm3'
  depends_on 'harfbuzz' # R
  depends_on 'libcpuid'
  depends_on 'libglvnd' # R
  depends_on 'libsigcplusplus2' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'pangomm_1_4' # R
  depends_on 'pciutils'
  depends_on 'procps' # R
  depends_on 'vulkan_headers'
  depends_on 'vulkan_icd_loader'
  depends_on 'zlib' # R

  cmake_options "-DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncurses -DWITH_OPENCL=OFF -DWITH_BANDWIDTH=OFF"
end
