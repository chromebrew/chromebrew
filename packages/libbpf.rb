# Adapted from Arch Linux libbpf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libbpf/trunk/PKGBUILD

require 'package'

class Libbpf < Package
  description 'Library for loading eBPF programs and reading and manipulating eBPF objects from user-space'
  homepage 'https://github.com/libbpf/libbpf'
  version '1.4.1'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libbpf/libbpf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6f41a3983e9ccea020f38d9c99e2d36fd5c0190114ffbfeb1cd22574b8ae9b5',
     armv7l: 'e6f41a3983e9ccea020f38d9c99e2d36fd5c0190114ffbfeb1cd22574b8ae9b5',
     x86_64: '706a0a3e8b7cb2bd1bd7916a9d89c5964ee12215a34725f1e6a500b8c9caaa3d'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
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
  end
end
