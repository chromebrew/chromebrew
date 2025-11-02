require 'package'

class Mg < Package
  description 'mg is the portable version of the mg editor from OpenBSD'
  homepage 'https://github.com/hboetes/mg/'
  version '20170917'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/hboetes/mg.git'
  git_hashtag version
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '9c9ee8e796407f78ce16b6f6da3c1faf2d04f1a6691bc2f020cf27258cfd585f',
     armv7l: '9c9ee8e796407f78ce16b6f6da3c1faf2d04f1a6691bc2f020cf27258cfd585f',
       i686: '9655b3efbe43f45e6ec46eb9f0ff36727f155e2dce90c5d3b03266b3df1c825c',
     x86_64: 'b33010e42645f5b311ca7b1ca3dcbab53ad033aab3cedab2ec6a3e73f7a1dafa'
  })

  depends_on 'ncurses'

  def self.build
    system "CFLAGS=-I#{CREW_PREFIX}/include/ncurses make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
