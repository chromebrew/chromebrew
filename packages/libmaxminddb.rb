# Adapted from Arch Linux libmaxminddb PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libmaxminddb/trunk/PKGBUILD

require 'package'

class Libmaxminddb < Package
  description 'MaxMind GeoIP2 database - split package with library and utilities'
  homepage 'https://dev.maxmind.com/geoip/geoip2/downloadable/'
  version '1.6.0'
  compatibility 'all'
  source_url 'https://github.com/maxmind/libmaxminddb.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmaxminddb/1.6.0_armv7l/libmaxminddb-1.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmaxminddb/1.6.0_armv7l/libmaxminddb-1.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmaxminddb/1.6.0_i686/libmaxminddb-1.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmaxminddb/1.6.0_x86_64/libmaxminddb-1.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6d09c6d9890b39ceace43afb36c2c06aa01542f69b9c387086d334688548a327',
     armv7l: '6d09c6d9890b39ceace43afb36c2c06aa01542f69b9c387086d334688548a327',
       i686: '74d46eb3f47e3dfdefdb03d037648dd60e2ca12919e25d2bbca5eb3dcd677276',
     x86_64: '134056b2bfb80d86b5d27aaa389855725f3454b21775326d0680f2bfd37bb07e'
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
