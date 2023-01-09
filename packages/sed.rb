require 'package'

class Sed < Package
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.9'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.9.tar.xz'
  source_sha256 '6e226b732e1cd739464ad6862bd1a1aba42d7982922da7a53519631d24975181'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.9_armv7l/sed-4.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.9_armv7l/sed-4.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.9_i686/sed-4.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.9_x86_64/sed-4.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '13f49db4006bd22a894f8c8f870635074438b1b125849ab14220e98205a6b56a',
     armv7l: '13f49db4006bd22a894f8c8f870635074438b1b125849ab14220e98205a6b56a',
       i686: 'b601023458812f12c08a5659d5e2033489f8a554fea17b92ea2761b909a3f863',
     x86_64: 'b0072a360f9a1e921e183f380934b67b5203b6de2104ddfb0441080bd7954bfe'
  })

  depends_on 'acl'
  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS} --without-selinux"
    system 'make'
  end

  def self.check
    # Remove selinux tests since we're building without it.
    system "sed -i 's,testsuite/inplace-selinux.sh ,,' Makefile"
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
