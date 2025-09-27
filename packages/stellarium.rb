require 'buildsystems/cmake'

class Stellarium < CMake
  description 'Stellarium is a free open source planetarium for your computer.'
  homepage 'http://stellarium.org/'
  version '25.2'
  license 'GPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Stellarium/stellarium.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50af206f72e561b669898288d303852f1051bb84228f1be49d42c26f4bc1abda',
     armv7l: '50af206f72e561b669898288d303852f1051bb84228f1be49d42c26f4bc1abda',
     x86_64: 'e6ac5599476caa03fd3f867f7a2792149932c2f2c1fb07f5ec47aae1ccb94aed'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libexiv2' # R
  depends_on 'nlopt' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_charts' # R
  depends_on 'qt5_location' # R
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
