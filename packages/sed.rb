require 'package'

class Sed < Package
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.8-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.8.tar.xz'
  source_sha256 'f79b0cfea71b37a8eeec8490db6c5f7ae7719c35587f21edb0617f370eeff633'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.8-1_armv7l/sed-4.8-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.8-1_armv7l/sed-4.8-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.8-1_i686/sed-4.8-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.8-1_x86_64/sed-4.8-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fd595a2f1e13c1e961e25fc22cc3407d8cb6b294bdae42736ac25678f862ae79',
     armv7l: 'fd595a2f1e13c1e961e25fc22cc3407d8cb6b294bdae42736ac25678f862ae79',
       i686: '051be8f498eaefaa5d1abc57e19f3205927fa35fcbf5cdb0c10368a0a89ec760',
     x86_64: '1d2c3988aa831e795c8a0f0b9c4345cd6e40c1df9a16960015bdef0aaf9e9387'
  })

  depends_on 'acl'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --without-selinux"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # Remove selinux tests since we're building without it.
    system "sed -i 's,testsuite/inplace-selinux.sh ,,' Makefile"
    system 'make', 'check'
  end
end
