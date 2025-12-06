require 'package'

class Pax_utils < Package
  description 'ELF utils that can check files for security relevant properties'
  homepage 'https://wiki.gentoo.org/wiki/Hardened/PaX_Utilities'
  version '1.3.10'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://anongit.gentoo.org/git/proj/pax-utils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b34d16064171427da557662ef22fdd165ca3b998d94d06fdbfc81cb4e12e4fd',
     armv7l: '6b34d16064171427da557662ef22fdd165ca3b998d94d06fdbfc81cb4e12e4fd',
       i686: '5fbad9b22b96385954ebdcdc078a4335a50c3174a01f699177d11cf38aa9764f',
     x86_64: '9a579a70d2b6fbe9fc8243b0f7a77bb285ac792fc5e1dea6d76cb151d54bc3d4'
  })

  depends_on 'glibc' # R
  depends_on 'libcap' # R
  depends_on 'libseccomp' => :build
  depends_on 'python3' # L
  depends_on 'xmlto' => :build

  def self.patch
    system "sed -i 's|/usr/bin/env python|/usr/bin/env python3|g' lddtree.py"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
            -Dlddtree_implementation=python \
            -Duse_libcap=enabled \
            -Duse_seccomp=true \
            builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
