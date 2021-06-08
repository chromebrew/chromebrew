require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '581.2'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'http://www.greenwoodsoftware.com/less/less-581.2.tar.gz'
  source_sha256 'ce34b47caf20a99740672bf560fc48d5d663c5e78e67bc254e616b9537d5d83b'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/581.2_armv7l/less-581.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/581.2_armv7l/less-581.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/581.2_i686/less-581.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/581.2_x86_64/less-581.2-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '1d7d98feb864c81610dd5430e993e7ce8ee97665854ea15ef89d333a464006b3',
     armv7l: '1d7d98feb864c81610dd5430e993e7ce8ee97665854ea15ef89d333a464006b3',
       i686: 'bc225d51f8de8850528c1d694cbb84aaaf9cdd9e10b3352b327de729e5daba1b',
     x86_64: '30fdb82765a4ae19196f3e95a74cf723e1f719e682cd7953e5415343a5217651',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-regex=posix"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
