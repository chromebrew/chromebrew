require 'package'

class Pax_utils < Package
  description 'ELF utils that can check files for security relevant properties'
  homepage 'https://wiki.gentoo.org/wiki/Hardened/PaX_Utilities'
  version '1.3.8'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://anongit.gentoo.org/git/proj/pax-utils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b244ed7adbbfa83c6a8353d29a5dc7759e04f305792bf453e1076f1046759579',
     armv7l: 'b244ed7adbbfa83c6a8353d29a5dc7759e04f305792bf453e1076f1046759579',
       i686: 'c4452f9fcea91e1d070848dcbcac595fd40e137cdcd232e6425d8c6e40356085',
     x86_64: '0e2e3923dd86ea4931ded5d0679b07e1c6e4bd0fc14d38ffc289a973d5d1d21d'
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
