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
    aarch64: '38116b047903f635e67bf4b9b1fc8eb6bada5013480b073a60f9506e3136caa6',
     armv7l: '38116b047903f635e67bf4b9b1fc8eb6bada5013480b073a60f9506e3136caa6',
       i686: 'ff66e74f21425bf869e92a6f432dea54814db453e84aa089d6ff788fb829a21b',
     x86_64: '34f1ffd939cfe497bc7cb5efde8526f51c3b78d2df48436586ef25795d849bc1'
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
