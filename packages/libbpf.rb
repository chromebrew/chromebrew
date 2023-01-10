# Adapted from Arch Linux libbpf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libbpf/trunk/PKGBUILD

require 'package'

class Libbpf < Package
  description 'Library for loading eBPF programs and reading and manipulating eBPF objects from user-space'
  homepage 'https://github.com/libbpf/libbpf'
  version '1.1.0'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libbpf/libbpf.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbpf/1.1.0_armv7l/libbpf-1.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbpf/1.1.0_armv7l/libbpf-1.1.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbpf/1.1.0_x86_64/libbpf-1.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fe66b50e10b69c3fe432ee271e6513718af791b9cec9bb0b8e5379d95e71fc78',
     armv7l: 'fe66b50e10b69c3fe432ee271e6513718af791b9cec9bb0b8e5379d95e71fc78',
     x86_64: 'ea164c187e69e6e8871ca17f3fd9dbfcaa9ff81680950c0b57cae82251721f26'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'rsync' => :build
  depends_on 'zlibpkg' # R

  def self.patch
    system "sed -i 's,PREFIX ?= /usr,PREFIX ?= #{CREW_PREFIX},g' src/Makefile"
  end

  def self.build
    system 'make -C src'
  end

  def self.install
    system "make -C src DESTDIR=#{CREW_DEST_DIR} LIBSUBDIR=#{ARCH_LIB} install install_headers"
    system "install -Dm 644 README.md -t #{CREW_DEST_PREFIX}/share/doc/libbpf"
  end
end
