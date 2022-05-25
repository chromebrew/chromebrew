# Adapted from Arch Linux libmaxminddb PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libmaxminddb/trunk/PKGBUILD

require 'package'

class Libmaxminddb < Package
  description 'MaxMind GeoIP2 database - split package with library and utilities'
  homepage 'https://dev.maxmind.com/geoip/geoip2/downloadable/'
  version '1.6.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/maxmind/libmaxminddb.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmaxminddb/1.6.0_armv7l/libmaxminddb-1.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmaxminddb/1.6.0_armv7l/libmaxminddb-1.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmaxminddb/1.6.0_i686/libmaxminddb-1.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmaxminddb/1.6.0_x86_64/libmaxminddb-1.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dd5d36efff43193b39e867aafa2d8dc62952dff8e4deb899bc39e118279a4ee7',
     armv7l: 'dd5d36efff43193b39e867aafa2d8dc62952dff8e4deb899bc39e118279a4ee7',
       i686: '86c9e0b36eac6fcf3aa8f2148e48820b6aac60cb0557ef2bee96fae026cc6316',
     x86_64: 'dde95291d323c066507792a3709e56faf4850341303a5b9e2cd0cf4da080bc17'
  })

  def self.patch
    system "sed -i '/set(CMAKE_C_EXTENSIONS OFF)/a include(GNUInstallDirs)' CMakeLists.txt"
    system "sed -i 's,DESTINATION lib,DESTINATION \${CMAKE_INSTALL_LIBDIR},g' CMakeLists.txt"
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DBUILD_SHARED_LIBS=ON \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
