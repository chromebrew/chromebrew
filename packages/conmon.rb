# Adapted from Arch Linux conmon PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/conmon/trunk/PKGBUILD

require 'package'

class Conmon < Package
  description 'OCI container runtime monitor'
  homepage 'https://github.com/containers/conmon'
  version '2.1.5'
  license 'APACHE'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/conmon.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e68f638ccb5491eea954ee2ca7092544d8ac8920eb301fddc310ad5ca66abc8',
     armv7l: '8e68f638ccb5491eea954ee2ca7092544d8ac8920eb301fddc310ad5ca66abc8',
     x86_64: '7bdddbdb011d0848c8e5e4d1ff7c209a803e1e722cf729d56b7331c6c2f1f67f'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'go_md2man' => :build
  depends_on 'runc' # L

  def self.patch
    system "sed -i 's,../tools/build/go-md2man,#{CREW_PREFIX}/bin/go-md2man,' docs/Makefile"
  end

  def self.build
    system "make PREFIX=#{CREW_PREFIX} LIBEXECDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
