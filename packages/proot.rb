# Adapted from Arch Linux proot PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=proot

require 'package'

class Proot < Package
  description 'Termux Proot: chroot, mount --bind, and binfmt_misc without privilege/setup for Linux'
  homepage 'https://github.com/termux/proot'
  version 'eca2225'
  license 'GPL-2.0-only'
  compatibility 'all'
  source_url 'https://github.com/termux/proot.git'
  git_hashtag 'eca2225f3a3ebacfb814dba411c1ef967ebe6420'
  binary_compression 'tar.zst'

  depends_on 'libarchive' => :build
  depends_on 'talloc' => :build
  depends_on 'libxslt' => :build

  def self.build
    system "make -f GNUmakefile", chdir: 'src'
    system "make -f GNUmakefile", chdir: 'doc'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make -f GNUmakefile install proot", chdir: 'src'
    FileUtils.install 'doc/proot/man.1', "#{CREW_DEST_MAN_PREFIX}/man1/proot.1", mode: 0o644
  end
end
