require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://cyan4973.github.io/xxHash/'
  version '0.8.0'
  compatibility 'all'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.8.0.tar.gz'
  source_sha256 '7054c3ebd169c97b64a92d7b994ab63c70dd53a06974f1f630ab782c28db0f4f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ce8bfe1e4f45e1f5ddd9b540bef8c5d17575a2e7f12ec11813c6e457b8f3100',
     armv7l: '3ce8bfe1e4f45e1f5ddd9b540bef8c5d17575a2e7f12ec11813c6e457b8f3100',
       i686: 'e13d6c726026d7926161eda09ddee6241f947e1d4854c8be3a4c4768443b890e',
     x86_64: '12a168084bccb1ab631ebdc6f785c485268bee73060cf2900c84fbe3b8e0b3d3',
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
