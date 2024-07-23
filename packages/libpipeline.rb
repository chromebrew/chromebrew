require 'package'

class Libpipeline < Package
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'
  version '1.5.3'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://mirror.csclub.uwaterloo.ca/nongnu/libpipeline/libpipeline-#{version}.tar.gz"
  source_sha256 '5dbf08faf50fad853754293e57fd4e6c69bb8e486f176596d682c67e02a0adb0'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '95c8b6b79ed89ff9214d8fcd8aa29af940517e5a77e369f509bb2e56a7518cd8',
     armv7l: '95c8b6b79ed89ff9214d8fcd8aa29af940517e5a77e369f509bb2e56a7518cd8',
       i686: 'f48dc0e7fa58b857de93c586c7eb80b473f1fb4b1ee617eec60304f76c280d22',
     x86_64: 'bcdc10711b7697fd61d50f996a5df4467702914d36823d7fbc62590b1f0a5ece'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure \
      #{CREW_OPTIONS} \
      --enable-shared \
      --with-pic"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
