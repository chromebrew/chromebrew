# Adapted from Arch Linux unibilium PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/unibilium/trunk/PKGBUILD

require 'package'

class Unibilium < Package
  description 'A terminfo parsing library'
  homepage 'https://github.com/neovim/unibilium'
  version '2.1.1'
  license 'LGPL3'
  compatibility 'all'
  source_url 'https://github.com/neovim/unibilium/archive/v2.1.1.tar.gz'
  source_sha256 '6f0ee21c8605340cfbb458cbd195b4d074e6d16dd0c0e12f2627ca773f3cabf1'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unibilium/2.1.1_armv7l/unibilium-2.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unibilium/2.1.1_armv7l/unibilium-2.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unibilium/2.1.1_i686/unibilium-2.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unibilium/2.1.1_x86_64/unibilium-2.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5ef4d9793a3679dc58bc75b493745d8821c10c0476f0f2734e2e2bdd60fd106d',
     armv7l: '5ef4d9793a3679dc58bc75b493745d8821c10c0476f0f2734e2e2bdd60fd106d',
       i686: 'ce3d2b5f614521d8b081720a9965564d19d3aca3d37fa41afaefc11452c2b17d',
     x86_64: 'f6531c4268d66b85dabce905041344c4166612823436e48aeb395ddefe58b732'
  })

  depends_on 'glibc'

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
