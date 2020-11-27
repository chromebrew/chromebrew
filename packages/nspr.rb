require 'package'

class Nspr < Package
  description 'Netscape Portable Runtime (NSPR) provides a platform-neutral API for system level and libc-like functions.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSPR'
  version '4.29'
  compatibility 'all'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_59_RTM/src/nss-3.59-with-nspr-4.29.tar.gz'
  source_sha256 '2e2c09c17b1c9f43a2f0a5d83a30a712bff3016d2b7cf5a3dd904847292607ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7fe5265f56931e762523e9412303ed9ed4befa69ddf9aa54216bbbeb51e75f5a',
     armv7l: '7fe5265f56931e762523e9412303ed9ed4befa69ddf9aa54216bbbeb51e75f5a',
       i686: 'b31f337c9e154bf363dd379c8616a453375f9b46dad68a4cebf575a90d394c93',
     x86_64: '1df12a62f4fbbe0424687e65c1d0f6de54f2e7594cb72d841de6893e4aa99e3c',
  })

  def self.build
    Dir.chdir 'nspr' do
      case ARCH
      when 'x86_64'
        system "./configure #{CREW_OPTIONS} --enable-64bit"
      else
        system "./configure #{CREW_OPTIONS}"
      end
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'nspr' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
