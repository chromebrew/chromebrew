require 'package'

class Nspr < Package
  description 'Netscape Portable Runtime (NSPR) provides a platform-neutral API for system level and libc-like functions.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSPR'
  version '4.22'
  compatibility 'all'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_46_RTM/src/nss-3.46-with-nspr-4.22.tar.gz'
  source_sha256 '3d4197196e870ab2dccc6ee497e0ec83f45ea070fee929dd931491c024d69f31'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nspr-4.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c271570497b6730a6161c8beca6dc3ebb19a882674cc547deb57ec5f175498ad',
     armv7l: 'c271570497b6730a6161c8beca6dc3ebb19a882674cc547deb57ec5f175498ad',
       i686: '743e748f70b5844d95f722426fc0d504a3475153bfc393b6bbb9ce17bf967383',
     x86_64: 'f49b5ca3842230a3542bbe2986fa2c644c9b89a6cb7c220cfe3ec10b67dc15ad',
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
