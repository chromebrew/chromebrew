require 'buildsystems/autotools'

class Mg < Autotools
  description 'mg is the portable version of the mg editor from OpenBSD'
  homepage 'https://github.com/hboetes/mg/'
  version '20260719'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/hboetes/mg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74a0c5cf3a39e0c6c8afa3d642ccd5c4d6034af079188ae6c0ad375f3eeedab1',
     armv7l: '74a0c5cf3a39e0c6c8afa3d642ccd5c4d6034af079188ae6c0ad375f3eeedab1',
       i686: '3b4eab529d77af292b04b4fa3e37a74b0d0f987d9c89efaab206ca12324fc1f1',
     x86_64: '58060e5b767e455f90b617c12c415e7d60b43737ab601fd4292ca0277421fd99'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libbsd' => :executable
  depends_on 'ncurses' => :executable

  autotools_skip_configure

  autotools_pre_make_options "CFLAGS=-I#{CREW_PREFIX}/include/ncursesw"

  def self.patch
    # Fix make: /usr/bin/pkg-config: No such file or directory.
    system "sed -i 's,/usr/bin/pkg-config,#{CREW_PREFIX}/bin/pkg-config,g' GNUmakefile"
  end
end
