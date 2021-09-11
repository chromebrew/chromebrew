require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '590'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/less/less-590.tar.gz'
  source_sha256 '6aadf54be8bf57d0e2999a3c5d67b1de63808bb90deb8f77b028eafae3a08e10'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/590_armv7l/less-590-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/590_armv7l/less-590-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/590_i686/less-590-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/590_x86_64/less-590-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '56244b1b648ddee1801596a1a6b07da06d1749cc1c222c9fb35e0c660764817e',
     armv7l: '56244b1b648ddee1801596a1a6b07da06d1749cc1c222c9fb35e0c660764817e',
       i686: '7e471501cba155fdff2734e56c631bb4c3d3d8c375533fda34876daf931d6766',
     x86_64: 'fe15b66e0ad8e0be7c3695ad601019ac5abd610e8680ab5b07b7f289510b87c2',
  })

  depends_on 'ncurses'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} --with-regex=posix"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
