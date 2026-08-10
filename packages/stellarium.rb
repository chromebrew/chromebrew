require 'buildsystems/cmake'

class Stellarium < CMake
  description 'Stellarium is a free open source planetarium for your computer.'
  homepage 'http://stellarium.org/'
  version '26.2'
  license 'GPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Stellarium/stellarium.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0df3f7eb6cb9f40a6423dba81717a1ac9c7cfd9715bd55c08d5f66f60e2443c8',
     armv7l: '0df3f7eb6cb9f40a6423dba81717a1ac9c7cfd9715bd55c08d5f66f60e2443c8',
     x86_64: 'eab55680175be3fb1111530f91d2cf2cab26b7c88712aecf57774d7fdc99d78a'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libexiv2' => :executable
  depends_on 'nlopt' => :executable
  depends_on 'qt5_base' => :library
  depends_on 'qt5_charts' => :executable
  depends_on 'qt5_location' => :executable
  depends_on 'qt5_multimedia' => :executable
  depends_on 'qt5_script' => :executable
  depends_on 'qt5_serialport' => :executable
  depends_on 'qt5_svg' => :executable
  depends_on 'qt5_tools' => :build
  depends_on 'qt5_wayland' => :build
  depends_on 'zlib' => :executable

  cmake_options '-DENABLE_GPS=0'

  def self.preflight
    MiscFunctions.check_free_disk_space(551550976)
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.stellarium")
  end
end
