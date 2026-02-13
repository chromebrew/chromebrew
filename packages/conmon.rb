# Adapted from Arch Linux conmon PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/conmon/trunk/PKGBUILD

require 'package'

class Conmon < Package
  description 'OCI container runtime monitor'
  homepage 'https://github.com/containers/conmon'
  version '2.2.1'
  license 'APACHE'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/conmon.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0c678144167a2f51bccbf3d7dac0979a107a3e23de9194ac258c420b6c5d367',
     armv7l: 'b0c678144167a2f51bccbf3d7dac0979a107a3e23de9194ac258c420b6c5d367',
     x86_64: '25b2564b8f093ae5a5af02600e112983fe9fd0ac73f09c87da0a9a74d49884b2'
  })

  depends_on 'glib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'go_md2man' => :build
  depends_on 'libseccomp' => :executable_only
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
