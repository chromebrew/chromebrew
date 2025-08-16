require 'package'

class Scdoc < Package
  description 'A simple man page generator for POSIX systems written in C99'
  homepage 'https://git.sr.ht/~sircmpwn/scdoc/'
  version '1.11.3'
  license 'MIT'
  # source_url 'https://git.sr.ht/~sircmpwn/scdoc.git' # Git url with .git at the end returns 403 Forbidden
  # git_hashtag @_ver
  compatibility 'all'
  source_url "https://git.sr.ht/~sircmpwn/scdoc/archive/#{version}.tar.gz"
  source_sha256 'e9ff9981b5854301789a6778ee64ef1f6d1e5f4829a9dd3e58a9a63eacc2e6f0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46e2a757ba83581eb8eed4b2ccbb70b3787791d7caa08913020fee754cdb4460',
     armv7l: '46e2a757ba83581eb8eed4b2ccbb70b3787791d7caa08913020fee754cdb4460',
       i686: 'a5792bb17872928aedb23298a2ef5a9d6199a34a41ec32fed784fe6f1dd23c84',
     x86_64: '44a8b34c96d79b583b8cdff0c0ad0d1e5fc2657c204bbe46d9df96348d43f4d5'
  })

  depends_on 'glibc' # R

  def self.patch
    # Build a dynamically linked binary
    system "sed -i 's:LDFLAGS+=-static:LDFLAGS+=:' Makefile" # Compile dynamically
  end

  def self.build
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
