# Adapted from Arch Linux conmon PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/conmon/trunk/PKGBUILD

require 'package'

class Conmon < Package
  description 'OCI container runtime monitor'
  homepage 'https://github.com/containers/conmon'
  version '2.1.13'
  license 'APACHE'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/conmon.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44765056e635186d2346c667a628c3e6c35ab96f145c5fe732519ea334024be9',
     armv7l: '44765056e635186d2346c667a628c3e6c35ab96f145c5fe732519ea334024be9',
     x86_64: '282e880b018ce286885eb4be27b24634b2ae6b7f88356a81befcfb1405357200'
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
