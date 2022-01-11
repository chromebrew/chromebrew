require 'package'

class Libebml < Package
  description 'libEBML is a C++ library to parse EBML files.'
  homepage 'https://matroska.org/downloads/libraries.html'
  @_ver = '1.4.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Matroska-Org/libebml.git'
  git_hashtag 'release-' + @_ver

  def self.patch
    downloader 'https://salsa.debian.org/multimedia-team/libebml/-/raw/master/debian/patches/0001-include-appropriate-header-files-for-std-numeric_lim.patch'
    abort 'Checksum mismatch :/ try again'.lightred unless Digest::SHA256.hexdigest( File.read("0001-include-appropriate-header-files-for-std-numeric_lim.patch") ) == 'e0662dddd31ffcc0581bbba25de707fe881e556eef540522eb9b7956cb3cd32c'
    system 'patch -Np1 -i 0001-include-appropriate-header-files-for-std-numeric_lim.patch'
  end

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
