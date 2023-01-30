# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'package'

class Upx < Package
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.0.2'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.2_armv7l/upx-4.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.2_armv7l/upx-4.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.2_i686/upx-4.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.2_x86_64/upx-4.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dc9823913706ce2e9d31679fb733ebbc947b000b1e70ef80b621f6cf7fcb1efe',
     armv7l: 'dc9823913706ce2e9d31679fb733ebbc947b000b1e70ef80b621f6cf7fcb1efe',
       i686: '3944e0d6ad263b5fef6318940f7e2b67f9f236dc71f61cf33c638068e8aa3481',
     x86_64: '19c01ac6154add7e3376c01ec179230118ea87147ef72874b69a4e466d80617e'
  })

  # depends_on 'ucl'
  depends_on 'gcc' # R
  depends_on 'glibc' # R

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DUPX_CONFIG_DISABLE_GITREV=true \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.check
    # samu does not work here.
    system 'ninja test -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
