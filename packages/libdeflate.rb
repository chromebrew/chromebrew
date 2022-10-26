require 'package'

class Libdeflate < Package
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  @_ver = '1.14'
  version @_ver
  compatibility 'all'
  license 'MIT'
  source_url 'https://github.com/ebiggers/libdeflate.git'
  git_hashtag "v#{@_ver}"

  depends_on 'glibc' # R

  # The next release of libdeflate will use cmake

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      PREFIX=#{CREW_PREFIX} \
      LIBDIR=#{CREW_LIB_PREFIX} \
      make"
  end
  
  def self.check
    system "env #{CREW_ENV_OPTIONS} \
      PREFIX=#{CREW_PREFIX} \
      LIBDIR=#{CREW_LIB_PREFIX} \
      make"
  end

  def self.install
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      DESTDIR=#{CREW_DEST_DIR} \
      PREFIX=#{CREW_PREFIX} \
      LIBDIR=#{CREW_LIB_PREFIX} \
      make install"
  end
end
