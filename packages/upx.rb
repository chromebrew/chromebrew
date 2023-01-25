# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'package'

class Upx < Package
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.0.1'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.1_armv7l/upx-4.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.1_armv7l/upx-4.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.1_i686/upx-4.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.1_x86_64/upx-4.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c7d3497ad54f327ae9cd8de79fe00c6515dae6e57c80beb247cf5165f3498397',
     armv7l: 'c7d3497ad54f327ae9cd8de79fe00c6515dae6e57c80beb247cf5165f3498397',
       i686: '2b7b9b0ceeafd6393741abbaf693465e632759a690e5dedebd84ccf882b8b2ff',
     x86_64: '1d60d569bffecf477e82a58e6285bfdc62c673c8b5329075d776a548e89d65ac'
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
