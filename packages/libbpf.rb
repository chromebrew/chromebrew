# Adapted from Arch Linux libbpf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libbpf/trunk/PKGBUILD

require 'package'

class Libbpf < Package
  description 'Library for loading eBPF programs and reading and manipulating eBPF objects from user-space'
  homepage 'https://github.com/libbpf/libbpf'
  version '0.7.0'
  license 'LGPL2.1'
  compatibility 'all'
  source_url 'https://github.com/libbpf/libbpf/archive/v0.7.0/libbpf-0.7.0.tar.gz'
  source_sha256 '5083588ce5a3a620e395ee1e596af77b4ec5771ffc71cff2af49dfee38c06361'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbpf/0.7.0_armv7l/libbpf-0.7.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbpf/0.7.0_armv7l/libbpf-0.7.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbpf/0.7.0_x86_64/libbpf-0.7.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3428813d83b350dc34a7d3b924234c27c85b1fcd09d62ee8ed9810607d93163f',
     armv7l: '3428813d83b350dc34a7d3b924234c27c85b1fcd09d62ee8ed9810607d93163f',
     x86_64: 'e9a7dadae061accb7a6a303be994d82bc16cac80c9bd5fb893277ae7b3ca5f47'
  })

  depends_on 'elfutils'
  depends_on 'rsync' => ':build'

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
