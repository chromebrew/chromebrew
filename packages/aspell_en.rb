require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'ftp://ftp.gnu.org/gnu/aspell/dict/0index.html'
  version '2017.08.24-0'
  source_url 'https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-2017.08.24-0.tar.bz2'
  source_sha256 '09b562b02195e7facd31d65241050be7ac6f78654128ab41650511bf42dd5b7c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2017.08.24-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2017.08.24-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2017.08.24-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2017.08.24-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a4c5413835190ca64d26ed007fa5da99b8567e2ba966748f93a0ba12cb4ceec1',
     armv7l: 'a4c5413835190ca64d26ed007fa5da99b8567e2ba966748f93a0ba12cb4ceec1',
       i686: '9d551f29ae82304dac697fd06077debb9734b071b32baf119ee24d7ff1c1f8aa',
     x86_64: 'b6ec346286f878be4ae79b54a230398c1b0160e39afbe537748994ac0c08d926',
  })

  depends_on 'aspell'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
