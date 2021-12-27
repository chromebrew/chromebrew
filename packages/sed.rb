require 'package'

class Sed < Package
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.8-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.8.tar.xz'
  source_sha256 'f79b0cfea71b37a8eeec8490db6c5f7ae7719c35587f21edb0617f370eeff633'

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
