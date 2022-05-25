require 'package'

class Wdiff < Package
  description 'The GNU wdiff program is a front end to diff for comparing files on a word per word basis.'
  homepage 'https://www.gnu.org/software/wdiff/'
  version '1.2.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/wdiff/wdiff-1.2.2.tar.gz'
  source_sha256 '34ff698c870c87e6e47a838eeaaae729fa73349139fc8db12211d2a22b78af6b'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wdiff/1.2.2_armv7l/wdiff-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wdiff/1.2.2_armv7l/wdiff-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wdiff/1.2.2_i686/wdiff-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wdiff/1.2.2_x86_64/wdiff-1.2.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e27cdc3a13508098ddb9e330758896596af712fb33ac4f6c5c17c1b41624ffa1',
     armv7l: 'e27cdc3a13508098ddb9e330758896596af712fb33ac4f6c5c17c1b41624ffa1',
       i686: '0e6c8306a0fe4ddff4b03ee541f1ffbaa92af829dac9d9681af9e6e6e381952a',
     x86_64: '091e34045534f4f777172e1f4a3c9e966377efa9158304f1bb15f31a3edc2dac'
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
