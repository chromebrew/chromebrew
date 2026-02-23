require 'buildsystems/autotools'

class Mg < Autotools
  description 'mg is the portable version of the mg editor from OpenBSD'
  homepage 'https://github.com/hboetes/mg/'
  version '20260222'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/hboetes/mg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36bae97597099703ff71866211fe876d5d6f15d3755086687e2199c155902265',
     armv7l: '36bae97597099703ff71866211fe876d5d6f15d3755086687e2199c155902265',
       i686: 'fd8d8397a24e0cd81e23f98e4f2f2d513d5f6ba51c4c2b7f367362d63a28e208',
     x86_64: 'e20dd714211d971b655f729b8b73a9757642b9a4948fc6557bde422314277e0d'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'libbsd' => :executable_only
  depends_on 'ncurses' => :executable_only

  autotools_skip_configure

  autotools_pre_make_options "CFLAGS=-I#{CREW_PREFIX}/include/ncursesw"

  def self.patch
    # Fix make: /usr/bin/pkg-config: No such file or directory.
    system "sed -i 's,/usr/bin/pkg-config,#{CREW_PREFIX}/bin/pkg-config,g' GNUmakefile"
  end
end
