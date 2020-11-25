require 'package'

class Nspr < Package
  description 'Netscape Portable Runtime (NSPR) provides a platform-neutral API for system level and libc-like functions.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSPR'
  version '4.29'
  compatibility 'all'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_59_RTM/src/nss-3.59-with-nspr-4.29.tar.gz'
  source_sha256 '2e2c09c17b1c9f43a2f0a5d83a30a712bff3016d2b7cf5a3dd904847292607ae'


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
