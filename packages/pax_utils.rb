require 'package'

class Pax_utils < Package
  description 'ELF utils that can check files for security relevant properties'
  homepage 'https://wiki.gentoo.org/wiki/Hardened/PaX_Utilities'
  version '1.3.11'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://anongit.gentoo.org/git/proj/pax-utils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ead3602892e6df841e856292a4789de7da58ef01bf0a9b002d05d2a3ed98541e',
     armv7l: 'ead3602892e6df841e856292a4789de7da58ef01bf0a9b002d05d2a3ed98541e',
       i686: 'ec9191886e5212dfdc67227935f36d7b668f611bb8c7db64f564af9d09534ed4',
     x86_64: 'b2f38631001deaace56ab05433fda52f8ca08a96742cfc8a565a59386fc8e103'
  })

  depends_on 'glibc' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libseccomp' => :build
  depends_on 'python3' => :logical
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
