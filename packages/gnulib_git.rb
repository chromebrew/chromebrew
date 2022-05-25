# Adapted from Arch Linux gnulib-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnulib-git

require 'package'

class Gnulib_git < Package
  description 'GNU Portability Library'
  homepage 'http://www.gnu.org/software/gnulib'
  version 'v0.1-96ad66e'
  license 'custom'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/gnulib.git'
  git_hashtag '96ad66ea76f65e6cf78c638b85696157ea6141df'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnulib_git/v0.1-96ad66e_armv7l/gnulib_git-v0.1-96ad66e-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnulib_git/v0.1-96ad66e_armv7l/gnulib_git-v0.1-96ad66e-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnulib_git/v0.1-96ad66e_i686/gnulib_git-v0.1-96ad66e-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnulib_git/v0.1-96ad66e_x86_64/gnulib_git-v0.1-96ad66e-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '46a09e50986f6c5b6620c31a59f305249bd512130b8f56c55637fc1e3959a38b',
     armv7l: '46a09e50986f6c5b6620c31a59f305249bd512130b8f56c55637fc1e3959a38b',
       i686: '9af10ea0d5fad6815cf4003ed0a7b087dc74ece726e0d8259016d5430a083bcf',
     x86_64: 'b3859447efe90847f53e127c688609aa26bffa5de654402a5ef82924a11e2519'
  })

  def self.patch
    system "sed -i \"/^[ ]*gnulib_dir=/s,\\`[^\\`]*\\`,#{CREW_PREFIX}/share/gnulib-git,\" gnulib-tool"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gnulib-git"
    FileUtils.install %w[check-module gnulib-tool], "#{CREW_DEST_PREFIX}/share/gnulib-git/", mode: 0o755
    FileUtils.cp_r %w[build-aux lib m4 modules top], "#{CREW_DEST_PREFIX}/share/gnulib-git"

    FileUtils.cp_r %w[doc tests], "#{CREW_DEST_PREFIX}/share/gnulib-git/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln "#{CREW_DEST_PREFIX}/share/gnulib-git/gnulib-tool", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln "#{CREW_DEST_PREFIX}/share/gnulib-git/check-module", "#{CREW_DEST_PREFIX}/bin/"
  end
end
