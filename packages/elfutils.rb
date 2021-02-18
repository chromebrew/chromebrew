require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  @_ver = '0.183'
  version @_ver
  compatibility 'all'
  source_url "https://sourceware.org/elfutils/ftp/#{@_ver}/elfutils-#{@_ver}.tar.bz2"
  source_sha256 'c3637c208d309d58714a51e61e63f1958808fead882e9b607506a29e5474f2c5'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.183-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.183-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.183-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.183-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0780ef4605befe8aa878d7f4997fa4431686f1a40851e513243cabf7d9d31bf8',
     armv7l: '0780ef4605befe8aa878d7f4997fa4431686f1a40851e513243cabf7d9d31bf8',
       i686: '894badb331f5d3d092d638b9b2dd2280677e97ffd9c4c37299cb40d529cbb609',
     x86_64: '73ba6638fd5929c232fc4442de938e25ca34ee66f91232ece874419b0f54cca6'
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-debuginfod"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
