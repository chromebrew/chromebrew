# Adapted from Arch Linux spirv-headers PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/spirv-headers/trunk/PKGBUILD

require 'package'

class Spirv_headers < Package
  description 'SPIR-V Headers'
  version '1.5.4-f88a'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers/archive/f88a1f98fa7a44ccfcf33d810c72b200e7d9a78a.zip'
  source_sha256 'b209fe7fd0db5a2eb61db5d93525ce0f39e4d615f2f82bd02ff0ee512bd45a1e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/spirv_headers-1.5.4-f88a-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/spirv_headers-1.5.4-f88a-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/spirv_headers-1.5.4-f88a-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/spirv_headers-1.5.4-f88a-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7fbc45daafcb8a8d2a2b677321df22f86797cc3cdd17b57e6ff6e56e6f00bc79',
     armv7l: '7fbc45daafcb8a8d2a2b677321df22f86797cc3cdd17b57e6ff6e56e6f00bc79',
       i686: '3b7e2d5cddd5a470bc44a2429559bd03aaa339e6fc2c16eee018b1758de5d6c6',
     x86_64: 'fe9c5758664a18559627bb5b1fda22ca5d5c6c6308ebf2d5bf6c65be393bf33a'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
