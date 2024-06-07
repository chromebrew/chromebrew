require 'package'

class Nethack < Package
  description 'Nethack is a classic roguelike. Descend through the dungeon and retrieve the Amulet of Yendor.'
  homepage 'https://www.nethack.org/'
  version '3.6.7'
  license 'nethack'
  compatibility 'all'
  source_url 'https://github.com/NetHack/NetHack.git'
  git_hashtag "NetHack-#{version}_Released"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f37b6c0eb4c63f3cd51e97b910cbcb2b22b5b7b0bb99052080460d3173ccd16a',
     armv7l: 'f37b6c0eb4c63f3cd51e97b910cbcb2b22b5b7b0bb99052080460d3173ccd16a',
       i686: 'b19d1508b6a70d8ab2a4b0fcde4a8069b7bd3d3d26bbe2318babe5fce1bcf1eb',
     x86_64: '03c389969a9c876c6edd529c51f8f2d128ee0a2965d10fc14f02c6f2e7db3aa1'
  })

  no_fhs

  def self.build
    ENV['GAME'] = 'nethack'
    system 'sys/unix/setup.sh sys/unix/hints/linux'
    Dir['**/Makefile'].each do |mkfile|
      system "sed -i 's,^HACKDIR=.*$,HACKDIR=#{CREW_PREFIX}/games/lib/nethackdir,g' #{mkfile}"
      system "sed -i 's,^PREFIX=\$(wildcard ~)/nh/install,PREFIX=#{CREW_DEST_PREFIX},' #{mkfile}"
      system "sed -i 's,\-I\.\./include,-I../include -I#{CREW_PREFIX}/include/ncursesw,' #{mkfile}"
    end
    system 'make'
  end

  def self.install
    system 'make', 'install'
    FileUtils.install "#{CREW_DEST_PREFIX}/games/nethack", "#{CREW_DEST_PREFIX}/bin/nethack", mode: 0o755
  end
end
