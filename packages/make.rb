require 'package'

class Make < Package
  description 'GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program\'s source files.'
  homepage 'https://www.gnu.org/software/make/'
  version '4.3'
  source_url 'https://ftpmirror.gnu.org/make/make-4.3.tar.lz'
  source_sha256 'de1a441c4edf952521db30bfca80baae86a0ff1acd0a00402999344f04c45e82'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/make-4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/make-4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/make-4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/make-4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '88a00eb5088f6a6b15c510f75040f7932b467e3f8306166052f24b56b4cd9405',
     armv7l: '88a00eb5088f6a6b15c510f75040f7932b467e3f8306166052f24b56b4cd9405',
       i686: '1138cb670502f23d7e0acf189b59982f045715693c143c982f96f4c77eca365b',
     x86_64: '26dee9755f910ebbc5e8742fc40937dc4b5900ded4a415b26aa282def3821d9d',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--enable-cross-guesses=conservative'
    system './build.sh'
  end

  def self.install
    system './make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # Give it several tries since output-sync fails rarely
    system './make check || ./make check || ./make check'
  end
end
