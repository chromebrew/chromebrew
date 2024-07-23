require 'package'

class Pax_utils < Package
  description 'ELF utils that can check files for security relevant properties'
  homepage 'https://wiki.gentoo.org/wiki/Hardened/PaX_Utilities'
  version '1.3.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://anongit.gentoo.org/git/proj/pax-utils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f05733d181ad32f5bd3795f592d1b30d1f46edb7c65a64c7cf1da8201bd44e02',
     armv7l: 'f05733d181ad32f5bd3795f592d1b30d1f46edb7c65a64c7cf1da8201bd44e02',
       i686: '98955a80c1b4a04ca942740663c6fb86bdae5f26505017c6b97f8fa6b9997fc4',
     x86_64: 'a2eec1aef128e76f8d22182bb97fad5b993930836a4e7ddc06a7b12acb9c67f8'
  })

  depends_on 'glibc' # R
  depends_on 'libcap' # R
  depends_on 'libseccomp' => :build
  depends_on 'py3_pyelftools' # R
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
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
