require 'package'

class Libdeflate < Package
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  @_ver = '1.17'
  version @_ver
  compatibility 'all'
  license 'MIT'
  source_url 'https://github.com/ebiggers/libdeflate.git'
  git_hashtag "v#{@_ver}"

  depends_on 'glibc' # R

  def self.build
    Dir.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
         .."
    end
    system 'samu -C builddir'
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
