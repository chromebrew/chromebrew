require 'package'

class Libsigsegv < Package
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.13'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libsigsegv/libsigsegv-2.13.tar.gz'
  source_sha256 'be78ee4176b05f7c75ff03298d84874db90f4b6c9d5503f0da1226b3a3c48119'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigsegv/2.13_armv7l/libsigsegv-2.13-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigsegv/2.13_armv7l/libsigsegv-2.13-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigsegv/2.13_i686/libsigsegv-2.13-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsigsegv/2.13_x86_64/libsigsegv-2.13-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1c521a9fcee6ae4108bd1177dfa053157f06a5b5931af65bfb5a1d0e52a27e75',
     armv7l: '1c521a9fcee6ae4108bd1177dfa053157f06a5b5931af65bfb5a1d0e52a27e75',
       i686: '964dc5402cb5106bd19f2a6a8ede6120d472313ce8998a1233bd2cbb97be3d07',
     x86_64: '68bad24a4b85d56bd45ca4f1af74ceb94829dd714be6622ac0c564f56030433f'
  })

  def self.build
    system 'autoreconf -fiv'
    # libsigsegv fails to build with LTO.
    system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
