# Adapted from Arch Linux crun PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/crun/trunk/PKGBUILD

require 'package'

class Crun < Package
  description 'A fast and lightweight fully featured OCI runtime and C library for running containers'
  homepage 'https://github.com/containers/crun'
  version '1.7.2'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/crun.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crun/1.7.2_armv7l/crun-1.7.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crun/1.7.2_armv7l/crun-1.7.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crun/1.7.2_x86_64/crun-1.7.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fe7f3f3282a8d05e76e9dd4036fa8b1761eee0cd5f7eed93c991365c9c17fc8e',
     armv7l: 'fe7f3f3282a8d05e76e9dd4036fa8b1761eee0cd5f7eed93c991365c9c17fc8e',
     x86_64: '49d7b8323992b044cd6a4658e7a66ce1f14f13c74ebf534870ff999819ddac4e'
  })

  depends_on 'criu' if ARCH == 'x86_64'
  depends_on 'glibc' # R
  depends_on 'go_md2man' => :build
  depends_on 'libbpf' => :build
  depends_on 'libcap' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libseccomp' # R
  depends_on 'yajl' # R

  def self.build
    @disable_criu = ARCH == 'x86_64' ? '' : '--disable-criu'
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      #{@disable_criu} \
      --disable-systemd \
      --enable-shared \
      --enable-dynamic \
      --with-python-bindings"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
