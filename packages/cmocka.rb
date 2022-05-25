# Adapted from Arch Linux cmocka PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cmocka/trunk/PKGBUILD

require 'package'

class Cmocka < Package
  description 'Elegant unit testing framework for C with support for mock objects'
  homepage 'https://cmocka.org/'
  version '1.1.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://cmocka.org/files/1.1/cmocka-1.1.5.tar.xz'
  source_sha256 'f0ccd8242d55e2fd74b16ba518359151f6f8383ff8aef4976e48393f77bba8b6'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmocka/1.1.5_armv7l/cmocka-1.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmocka/1.1.5_armv7l/cmocka-1.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmocka/1.1.5_i686/cmocka-1.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmocka/1.1.5_x86_64/cmocka-1.1.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3697a4226d1da0acfd5f462f645eb31886e41ade46c10b4ba211367c55f5b820',
     armv7l: '3697a4226d1da0acfd5f462f645eb31886e41ade46c10b4ba211367c55f5b820',
       i686: '615a38e2ca90d0c80d391f68994a0abe461152029e1b33b8a70f53a60b4eb212',
     x86_64: 'cb38f5c12d18bef0836dbbb36309da030aedb6275aca3ec610fabf987450ef56'
  })

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-fno-stack-protector/g' CompilerChecks.cmake"
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # See GCC linking issue w/ LTO here: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88643
      system "env CC=clang CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -fuse-ld=lld -flto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -fuse-ld=lld -flto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -fuse-ld=lld -flto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DUNIT_TESTING=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
