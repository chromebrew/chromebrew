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
    aarch64: 'ef1d4ac65976cb544587eba612821ba514316c2910307ece17f06725abe7337d',
     armv7l: 'ef1d4ac65976cb544587eba612821ba514316c2910307ece17f06725abe7337d',
     x86_64: '2554a5dd5092bc501e88f653ce755382b66f20b9e39036f7fa3b5664e0ed0d3f'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'go_md2man' => :build
  depends_on 'libseccomp' # R
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
