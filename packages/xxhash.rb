require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://cyan4973.github.io/xxHash/'
  version '0.8.0'
  compatibility 'all'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.8.0.tar.gz'
  source_sha256 '7054c3ebd169c97b64a92d7b994ab63c70dd53a06974f1f630ab782c28db0f4f'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install' 
  end
end
