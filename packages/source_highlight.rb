# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'package'

class Source_highlight < Package
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version '3.1.9-9049-1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/src-highlite.git'
  git_hashtag '904949c9026cb772dc93fbe0947a252ef47127f4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-9049-1_armv7l/source_highlight-3.1.9-9049-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-9049-1_armv7l/source_highlight-3.1.9-9049-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-9049-1_i686/source_highlight-3.1.9-9049-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-9049-1_x86_64/source_highlight-3.1.9-9049-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5c5660558f3a902622714f0c5562aa49b4e2c4ebcf54867b25205656c23d3251',
     armv7l: '5c5660558f3a902622714f0c5562aa49b4e2c4ebcf54867b25205656c23d3251',
       i686: '1032b43c246c0e8d95392437112d49f48ce2d5d52f0be5d42944459b0067506b',
     x86_64: '89797072609793b821f66c9069e96bdb8c02db74545968728a681de6c59d16ed'
  })

  depends_on 'boost' # R
  depends_on 'ctags' => :build
  depends_on 'texinfo' => :build

  def self.build
    system 'NOCONFIGURE=1 autoreconf -fiv'
    system 'filefix'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --with-bash-completion=#{CREW_PREFIX}/share/bash-completion/completions"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "make prefix=#{CREW_DEST_PREFIX} bash_completiondir=#{CREW_DEST_PREFIX}/share/bash-completion/completions install"
  end
end
