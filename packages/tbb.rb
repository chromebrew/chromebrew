# Adapted from Arch Linux tbb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tbb/trunk/PKGBUILD

require 'package'

class Tbb < Package
  description 'High level abstract threading library'
  homepage 'https://www.threadingbuildingblocks.org/'
  version '2021.5.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oneapi-src/oneTBB.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tbb/2021.5.0_armv7l/tbb-2021.5.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tbb/2021.5.0_armv7l/tbb-2021.5.0-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tbb/2021.5.0_i686/tbb-2021.5.0-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tbb/2021.5.0_x86_64/tbb-2021.5.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f4e39ecbe901b49bc1923cc10b136b5fd01f5c73148d5d15a4dc78455ad80a07',
     armv7l: 'f4e39ecbe901b49bc1923cc10b136b5fd01f5c73148d5d15a4dc78455ad80a07',
    i686: '7c3f26b5adca0413f399967769810420a00472f96189b98d9f474545da1f8086',
  x86_64: 'e74dd3ba705401c6aba67c459a3522712c56aaacb0768312ddaeb5e5a257f04b'
  })

  depends_on 'hwloc'
  depends_on 'swig' => :build

  def self.build
    @tbb_cmake_options = if ARCH == 'i686'
                           CREW_CMAKE_OPTIONS.gsub("_FLAGS='-O2",
                                                   "_FLAGS='-O2 -mwaitpkg")
                         else
                           CREW_CMAKE_OPTIONS
                         end
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{@tbb_cmake_options} \
      -DTBB4PY_BUILD=ON \
      -DTBB_TEST=OFF \
      ../ -G Ninja"
    end
    system 'samu -C builddir python_build all'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
