require 'buildsystems/autotools'

class Mg < Autotools
  description 'mg is the portable version of the mg editor from OpenBSD'
  homepage 'https://github.com/hboetes/mg/'
  version '20260227'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/hboetes/mg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a69ba6284b041bd57d87285b9600b445c35718104f77078c60789c527a6cfcbb',
     armv7l: 'a69ba6284b041bd57d87285b9600b445c35718104f77078c60789c527a6cfcbb',
       i686: 'd455d153f7c3f2d65988987369212a93cb1f4b34f28e3f2c1da120ff1ce001b1',
     x86_64: 'f0c1b137bba90d5e9203b5f83b432aaccf6b8fdcaa20a976737829e24e78f0d9'
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
