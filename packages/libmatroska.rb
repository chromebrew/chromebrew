require 'package'

class Libmatroska < Package
  description 'libmatroska is a C++ library to parse Matroska files, i.e., .mkv and .mka.'
  homepage 'https://matroska.org/downloads/libraries.html'
  @_ver = '1.6.3'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Matroska-Org/libmatroska.git'
  git_hashtag 'release-' + @_ver

  depends_on 'libebml'

  def self.build
    for dirname in ['builddir-static', 'builddir-shared'] do
      buildshared = if dirname == 'builddir-shared' then '-DBUILD_SHARED_LIBS=YES'
                    else ''
                    end
      FileUtils.mkdir dirname
      Dir.chdir dirname do
        system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
                #{buildshared} .."
      end
      system "samu -C #{dirname}"
    end
  end

  def self.install
    for dirname in ['builddir-static', 'builddir-shared'] do
      system "DESTDIR=#{CREW_DEST_DIR} samu -C #{dirname} install"
    end
  end
end
