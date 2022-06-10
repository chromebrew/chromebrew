require 'package'

class Openjpeg < Package
  description 'An open source JPEG 2000 codec, written in C.'
  homepage 'https://github.com/uclouvain/openjpeg'
  version '2.5.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.5.0.tar.gz'
  source_sha256 '0333806d6adecc6f7a91243b2b839ff4d2053823634d4f6ed7a59bc87409122a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openjpeg/2.5.0_armv7l/openjpeg-2.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openjpeg/2.5.0_armv7l/openjpeg-2.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openjpeg/2.5.0_i686/openjpeg-2.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openjpeg/2.5.0_x86_64/openjpeg-2.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e8f47ab6ee2e585d41a40def616a99e8c38855cb286a687c264bddc62666f41b',
     armv7l: 'e8f47ab6ee2e585d41a40def616a99e8c38855cb286a687c264bddc62666f41b',
       i686: '3cea296254991ddd62be39c5ec3cc901343ec4e06cc5896146780b14fb270cd6',
     x86_64: '47261041b12e3bb63bc2cd47d285afcc8fabdcd1075b80db0c1a35bf3267a826'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -DOPENJPEG_INSTALL_LIB_DIR='lib#{CREW_LIB_SUFFIX}' \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
