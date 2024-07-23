require 'package'

class Libebml < Package
  description 'libEBML is a C++ library to parse EBML files.'
  homepage 'https://matroska.org/downloads/libraries.html'
  version '1.4.2'
  compatibility 'all'
  license 'BSD'
  source_url 'https://github.com/Matroska-Org/libebml.git'
  git_hashtag "release-#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '4adbc9698b598878d1ca9fdc21c76361bfb9e3f08adeb8ff50570a866e14b0ba',
      armv7l: '4adbc9698b598878d1ca9fdc21c76361bfb9e3f08adeb8ff50570a866e14b0ba',
        i686: 'f2cd127f93560c8e8bc699078c9536ce11f8cf7fe5c6e38636356918c218eb6f',
      x86_64: '81b8fa3d73076c92aa862b74e9d1cc90203dde5cce9c6f26831cce6d8290da2b'
  })

  def self.patch
    downloader 'https://salsa.debian.org/multimedia-team/libebml/-/raw/master/debian/patches/0001-include-appropriate-header-files-for-std-numeric_lim.patch',
               'e0662dddd31ffcc0581bbba25de707fe881e556eef540522eb9b7956cb3cd32c'

    system 'patch -Np1 -i 0001-include-appropriate-header-files-for-std-numeric_lim.patch'
  end

  def self.build
    %w[builddir-static builddir-shared].each do |dirname|
      buildshared = if dirname == 'builddir-shared' then '-DBUILD_SHARED_LIBS=YES'
                    else
                      ''
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
    %w[builddir-static builddir-shared].each do |dirname|
      system "DESTDIR=#{CREW_DEST_DIR} samu -C #{dirname} install"
    end
  end
end
