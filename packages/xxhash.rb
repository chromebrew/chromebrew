require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://cyan4973.github.io/xxHash/'
  version '0.8.0-1'
  compatibility 'all'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.8.0.tar.gz'
  source_sha256 '7054c3ebd169c97b64a92d7b994ab63c70dd53a06974f1f630ab782c28db0f4f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.8.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.8.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.8.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.8.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3b84bfc646e491a012434a68aebd38c10a7c667096b7ba9aba0fd1d8899a34f6',
     armv7l: '3b84bfc646e491a012434a68aebd38c10a7c667096b7ba9aba0fd1d8899a34f6',
       i686: '341858534ccf356d1b6a7313b07f36c42da188a2055ac610bb8dd715ada0227d',
     x86_64: 'a6d0d300a1e11a255d545f759598c35b280083055954765c4f68e5c733e74ecc',
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
