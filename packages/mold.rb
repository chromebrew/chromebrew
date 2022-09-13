# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.4.2-9fd8313'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag '9fd831365738b58c4e5d5b3593aedc940941315b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-9fd8313_armv7l/mold-1.4.2-9fd8313-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-9fd8313_armv7l/mold-1.4.2-9fd8313-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-9fd8313_i686/mold-1.4.2-9fd8313-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-9fd8313_x86_64/mold-1.4.2-9fd8313-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1d7b45137dae71a5bc867659330be0e999291438500d12915335a56a1d70ee8c',
     armv7l: '1d7b45137dae71a5bc867659330be0e999291438500d12915335a56a1d70ee8c',
       i686: 'e11edb8d2379395b84dd3169a7d4e0e054483bc750eb2a221205739969a190bd',
     x86_64: '2d7b37dd3fa6893eb83ac78890ec00682807c5d350d5b2c224f8dfa61008cad5'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc' # R
  depends_on 'xxhash' => :build
  no_env_options

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        -DBUILD_TESTING=OFF \
        -DMOLD_USE_MOLD=ON \
        -DMOLD_LTO=ON \
        -Wno-dev \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    # See https://github.com/rui314/mold/issues/697
    return unless ARCH == 'x86_64'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/mold"
    FileUtils.ln "#{CREW_DEST_LIB_PREFIX}/mold/mold-wrapper.so", "#{CREW_DEST_PREFIX}/lib/mold/mold-wrapper.so"
  end
end
