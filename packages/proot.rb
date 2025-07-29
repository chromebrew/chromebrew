# Adapted from Arch Linux proot PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=proot

require 'package'

class Proot < Package
  description 'Termux Proot: chroot, mount --bind, and binfmt_misc without privilege/setup for Linux'
  homepage 'https://github.com/termux/proot'
  version '5.4.0'
  license 'GPL-2.0-only'
  compatibility 'all'
  source_url 'https://github.com/proot-me/proot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c7e4903579f6db73528dae1d5db54bcf23b5f3c95f3c6a7c71556c82796cd8d',
     armv7l: '9c7e4903579f6db73528dae1d5db54bcf23b5f3c95f3c6a7c71556c82796cd8d',
       i686: '2a583b7c3d1a3e1c62a86f68c0021a606162b981e520e9905944d6133668b915',
     x86_64: '53eb6c75f0923cbc03bb4a4ae691d50534bfa6518f2b07810dbb5b2fc99572c7'
  })

  depends_on 'libarchive' => :build
  depends_on 'talloc' => :build
  depends_on 'libxslt' => :build
  depends_on 'glibc' # R
  depends_on 'talloc' # R

  def self.patch
    downloader 'https://github.com/proot-me/proot/pull/398.patch', '4c1149819e5aafc088b0dadbd8a9ddf6ca8e6b9ceb10b9574704f68f5a8549a2'
    system 'patch -Np1 -i 398.patch'
  end

  def self.build
    system 'make -f GNUmakefile', chdir: 'src'
    system 'make -f GNUmakefile', chdir: 'doc'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make -f GNUmakefile install proot", chdir: 'src'
    FileUtils.install 'doc/proot/man.1', "#{CREW_DEST_MAN_PREFIX}/man1/proot.1", mode: 0o644
  end
end
