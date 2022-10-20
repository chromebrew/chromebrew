require 'package'

class Scdoc < Package
  description 'A simple man page generator for POSIX systems written in C99'
  homepage 'https://git.sr.ht/~sircmpwn/scdoc/'
  @_ver = '1.11.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  # source_url 'https://git.sr.ht/~sircmpwn/scdoc.git' # Git url with .git at the end returns 403 Forbidden
  # git_hashtag @_ver
  source_url "https://git.sr.ht/~sircmpwn/scdoc/archive/#{@_ver}.tar.gz"
  source_sha256 "e9ff9981b5854301789a6778ee64ef1f6d1e5f4829a9dd3e58a9a63eacc2e6f0"  

  def self.patch
    # Use correct gcc compiler
    system "sed -i '2 s:^:CC = #{CREW_TGT}-gcc\\n:' Makefile"

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
