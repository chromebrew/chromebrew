require 'package'

class Libaudiofile < Package
  description 'The Audio File Library is a C-based library for reading and writing audio files in many common formats.'
  homepage 'https://audiofile.68k.org/'
  version 'b62c90'
  compatibility 'all'
  source_url 'https://github.com/mpruett/audiofile/archive/b62c902dd258125cac86cd2df21fc898035a43d3.tar.gz'
  source_sha256 '808aff989a24ee3b60d3f08897d90ca45a031c95c42fe22d4fd913042c1ce307'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libaudiofile-b62c90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libaudiofile-b62c90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libaudiofile-b62c90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libaudiofile-b62c90-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4d4f7ea006f09f5777c2998775f6dd49e4ddf91ac40c3cdad09e94b5f1016ddc',
     armv7l: '4d4f7ea006f09f5777c2998775f6dd49e4ddf91ac40c3cdad09e94b5f1016ddc',
       i686: '0302ccfddd315e8fcbc58c2139463b03da3352dacc83a4e424130d15fdca1da1',
     x86_64: 'f74fa54401206607f94c5c76e8ba8bcedc13b202ed64262785b2ab11d7eb87db',
  })

  depends_on 'flac'

  def self.build
    system './autogen.sh'
    # Fix ./configure: line 7237: /usr/bin/file: No such file or directory
    system 'filefix'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-docs'
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
