require 'package'

class Sed < Package
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.8'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.8.tar.xz'
  source_sha256 'f79b0cfea71b37a8eeec8490db6c5f7ae7719c35587f21edb0617f370eeff633'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '362e263677dcf8ac059f1bbc27b5193f4ce05e52fff1295f8faae559778e5b50',
     armv7l: '362e263677dcf8ac059f1bbc27b5193f4ce05e52fff1295f8faae559778e5b50',
       i686: 'eb6cda5a3cd77cf5a155f6593afefe4417ab8a679f197c9706e4ae3ef16b01dc',
     x86_64: 'f0179b4feee9f5f130fdd6af0718c91de52c606343d1672e2b229c8581b9914f',
  })

  depends_on 'acl'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--without-selinux'
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
