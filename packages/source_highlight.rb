# Adapted from Arch Linux source-highlight PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/source-highlight/trunk/PKGBUILD

require 'package'

class Source_highlight < Package
  description 'Convert source code to syntax highlighted document'
  homepage 'https://www.gnu.org/software/src-highlite/'
  version '3.1.9-9049'
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/src-highlite.git'
  git_hashtag '904949c9026cb772dc93fbe0947a252ef47127f4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-9049_armv7l/source_highlight-3.1.9-9049-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-9049_armv7l/source_highlight-3.1.9-9049-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-9049_i686/source_highlight-3.1.9-9049-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/source_highlight/3.1.9-9049_x86_64/source_highlight-3.1.9-9049-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd684918851e16cda44873f6f9d70f9c7c1d65c93689851de6cbc9a6024311986',
     armv7l: 'd684918851e16cda44873f6f9d70f9c7c1d65c93689851de6cbc9a6024311986',
       i686: 'a177f2214443d14111a75242e97b1f3b45d2d5dcfc23a5336215a358b6f80a9a',
     x86_64: '1e0ea17e28e39601fb97771dfa75f13dc9a5b9a201381f0470ce3a7f5d2d12e1'
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
