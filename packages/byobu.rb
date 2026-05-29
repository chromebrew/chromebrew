require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1ed2de894e01c3dda8a186317a1a6cd1240424043ea8d3ac804717ce8282da7',
     armv7l: 'f1ed2de894e01c3dda8a186317a1a6cd1240424043ea8d3ac804717ce8282da7',
       i686: '4e7fa63f032f65a256bea617df28360e2ae0ede08f9044952f27f048f242412f',
     x86_64: 'a40f10b05f7a313c7d340e47c9ae49cb2d6c9d571b6c2785a52a210ef6d0e661'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
