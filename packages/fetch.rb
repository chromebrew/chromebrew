require 'package'

class Fetch < Package
  description 'FreeBSD Fetch retrieves files by URL.'
  homepage 'https://github.com/jrmarino/fetch-freebsd/'
  @_ver = '12.0.10'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/jrmarino/fetch-freebsd.git'
  git_hashtag 'v' + @_ver

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
              -DFETCH_LIBRARY=ON \
              -DFETCH_PROGRAM=ON \
              -DUSE_SYSTEM_SSL=ON .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    if CREW_LIB_SUFFIX == '64'
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/lib/*"), CREW_DEST_LIB_PREFIX
      FileUtils.rm_r "#{CREW_DEST_PREFIX}/lib/"
    end
  end
end
