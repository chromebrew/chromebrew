# Adapted from Arch Linux libcue PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcue/trunk/PKGBUILD

require 'package'

class Libcue < Package
  description 'Parses so-called cue sheets and handles the parsed data'
  homepage 'https://github.com/lipnitsk/libcue/'
  version '2.2.1'
  license 'GPLv2'
  compatibility 'all'
  source_url 'https://github.com/lipnitsk/libcue/archive/v2.2.1.tar.gz'
  source_sha256 'f27bc3ebb2e892cd9d32a7bee6d84576a60f955f29f748b9b487b173712f1200'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libcue-2.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libcue-2.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/libcue-2.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/libcue-2.2.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e0875a11ffd4f82d46b244475398faa8116b924eec61af1dc80e3986b257452c',
     armv7l: 'e0875a11ffd4f82d46b244475398faa8116b924eec61af1dc80e3986b257452c',
       i686: 'ce34d96bda58c74bcf890d04b9823cd82db88b78fb5d5a76db55f7411f0511e0',
     x86_64: '3f6ebdaad529d00267a00c27bfc1947849cb7c2fc29083c3a386507869c6b9cb'
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
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
