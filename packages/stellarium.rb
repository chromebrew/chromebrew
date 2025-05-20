require 'buildsystems/cmake'

class Stellarium < CMake
  description 'Stellarium is a free open source planetarium for your computer.'
  homepage 'http://stellarium.org/'
  version '24.3'
  license 'GPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'
  source_url 'https://github.com/Stellarium/stellarium.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd548e884494c873af710087dbfbe368add12273256894d3025bc61d58a254ef',
     armv7l: 'bd548e884494c873af710087dbfbe368add12273256894d3025bc61d58a254ef',
     x86_64: '1f3493b31364ba7019186d10ec2881710c887b7a7595d5d08e29feea0295cebf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'nlopt' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_charts' # R
  depends_on 'qt5_location' => :build
  depends_on 'qt5_multimedia' # R
  depends_on 'qt5_script' # R
  depends_on 'qt5_serialport' # R
  depends_on 'qt5_tools' => :build
  depends_on 'qt5_wayland' => :build
  depends_on 'zlib' # R

  cmake_options '-DENABLE_GPS=0'

  def self.preflight
    MiscFunctions.check_free_disk_space(551550976)
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.stellarium")
  end
end
