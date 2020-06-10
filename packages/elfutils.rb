require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.178'
  compatibility 'all'
  source_url 'https://sourceware.org/elfutils/ftp/0.178/elfutils-0.178.tar.bz2'
  source_sha256 '31e7a00e96d4e9c4bda452e1f2cdac4daf8abd24f5e154dee232131899f3a0f2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.178-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.178-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.178-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.178-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bbb5f8ab0208492e735585d2623f29b19326b4cc7a9201fa8f04fa1144f9583e',
     armv7l: 'bbb5f8ab0208492e735585d2623f29b19326b4cc7a9201fa8f04fa1144f9583e',
       i686: '6213446efdfc5c588b323125a38f1c48383826831925084368a239a437dc137e',
     x86_64: 'd34976b47335c47f8d4c88794789285971c4171d9c2aec9dae31ab9df06a5210',
  })

  depends_on 'xzutils'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-debuginfod"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
