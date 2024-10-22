require 'buildsystems/cmake'

class Stellarium < CMake
  description 'Stellarium is a free open source planetarium for your computer.'
  homepage 'http://stellarium.org/'
  version '24.2'
  license 'GPL-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.37'
  source_url 'https://github.com/Stellarium/stellarium.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d92d053882ddb66a6eeba455ede459a8ad897117603176826cc0e8804647e10',
     armv7l: '5d92d053882ddb66a6eeba455ede459a8ad897117603176826cc0e8804647e10',
     x86_64: '9ea039537005dafbbe3fc9faf989f4dbd7731c6f74e213d6c925b2b75a54d7d8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
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

  def self.postremove
    Package.agree_to_remove("#{HOME}/.stellarium")
  end
end
