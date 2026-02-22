require 'buildsystems/autotools'

class Mg < Autotools
  description 'mg is the portable version of the mg editor from OpenBSD'
  homepage 'https://github.com/hboetes/mg/'
  version '20250523'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/hboetes/mg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cbb39e5be4fef7fc2f063ddc015583cdee47ade599d8e72a415f417b0db077de',
     armv7l: 'cbb39e5be4fef7fc2f063ddc015583cdee47ade599d8e72a415f417b0db077de',
       i686: '753a9de0f056eb3691e9110f8768a8fc415312b2f617492c5a9c22a648d84126',
     x86_64: '382d1b4e27864d2134737e98d8502ab5bc528587f18af9abe4c126213867a287'
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
