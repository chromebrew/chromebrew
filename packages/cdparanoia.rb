# Adapted from Arch Linux cdparanoia PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/cdparanoia/trunk/PKGBUILD

require 'package'

class Cdparanoia < Package
  description 'Compact Disc Digital Audio extraction tool'
  homepage 'https://www.xiph.org/paranoia/'
  version '10.2'
  license 'GPL'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/cdparanoia/cdparanoia-III-10.2.src.tgz'
  source_sha256 '005db45ef4ee017f5c32ec124f913a0546e77014266c6a1c50df902a55fe64df'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cdparanoia/10.2_armv7l/cdparanoia-10.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cdparanoia/10.2_armv7l/cdparanoia-10.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cdparanoia/10.2_i686/cdparanoia-10.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cdparanoia/10.2_x86_64/cdparanoia-10.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '30175dd7636d51bbcc7c0feb194c7671ac80607abc8e2934d204279a2a5eda16',
     armv7l: '30175dd7636d51bbcc7c0feb194c7671ac80607abc8e2934d204279a2a5eda16',
       i686: 'eb06f87aaf715e636efcc5a2411c619c4fb8581e2d59bddfae37300ab1c23859',
     x86_64: '14c5f3136ce27847166d7947c22a3b31440113f8d21b8f3d9b29176df8e89bbf'
  })

  depends_on 'glibc'

  no_env_options

  def self.patch
    downloader 'https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/cdparanoia/trunk/gcc.patch',
               '9a3f3802856e96080fb30562a10899ef3378723e85f289fa29619b21d6051575'
    system 'patch -Np0 -i gcc.patch'
  end

  def self.build
    system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make prefix=#{CREW_DEST_PREFIX} MANDIR=#{CREW_DEST_MAN_PREFIX} install"
  end
end
