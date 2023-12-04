require 'package'

class Nethogs < Package
  description "Linux 'net top' tool"
  homepage 'https://github.com/raboof/nethogs'
  version '0.8.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/raboof/nethogs.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nethogs/0.8.7_armv7l/nethogs-0.8.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nethogs/0.8.7_armv7l/nethogs-0.8.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nethogs/0.8.7_i686/nethogs-0.8.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nethogs/0.8.7_x86_64/nethogs-0.8.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8a8b4e25bd6fd1a3df1d9fb9c0376332b76b5276b36f22a2f87fe0747e8c6d24',
     armv7l: '8a8b4e25bd6fd1a3df1d9fb9c0376332b76b5276b36f22a2f87fe0747e8c6d24',
       i686: '5701e00bfea5af2b08ab7115db03b579306a3cba427fb3680c6f6d501c9d635c',
     x86_64: '372a053ebcf2cee7e02f0ae832b9e4744ad25c5d248fad429daef55015ecea30'
  })

  depends_on 'ncurses'
  depends_on 'libpcap'

  def self.build
    system "PREFIX=#{CREW_PREFIX} CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw' make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
