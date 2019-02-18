require 'package'

class Nspr < Package
  description 'Netscape Portable Runtime (NSPR) provides a platform-neutral API for system level and libc-like functions.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSPR'
  version '4.20'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_42_RTM/src/nss-3.42-with-nspr-4.20.tar.gz'
  source_sha256 '59a0f6f4209b4066702c20c75d6b5531c92b6b3a7bc938b56aa3891c808860dd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '26aeff4a3365e980c18d543bddd9d5b2fc6f33a599ba66cb22e1c47538c34ac2',
     armv7l: '26aeff4a3365e980c18d543bddd9d5b2fc6f33a599ba66cb22e1c47538c34ac2',
       i686: 'c8356ba7dd10bc68bebc4ca67988f234d095fc1823999a1bc2135f81aa29586b',
     x86_64: '3632fc729b387d06d9f4b551278f120c56549af288dcd1d78267a5df140fe031',
  })

  def self.build
    Dir.chdir 'nspr' do
      case ARCH
      when 'x86_64'
        system './configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               '--enable-64bit'
      else
        system './configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}"
     end
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'nspr' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
