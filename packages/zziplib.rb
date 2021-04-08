require 'package'

class Zziplib < Package
  description 'The ZZIPlib provides read access on ZIP-archives and unpacked data.'
  homepage 'http://zziplib.sourceforge.net/'
  version '0.13.72'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gdraheim/zziplib/archive/refs/tags/v0.13.72.tar.gz'
  source_sha256 '93ef44bf1f1ea24fc66080426a469df82fa631d13ca3b2e4abaeab89538518dc'

  depends_on 'zlibpkg'
  depends_on 'xmlto' => :build

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
                -DCP=/bin/cp \
                -DGZIP=/bin/gzip \
                -DMKZIP=/usr/local/bin/zip \
                -DMV=/bin/mv \
                -DPKG_CONFIG_EXECUTABLE=/usr/local/bin/pkgconfig \
                -DPYTHON_EXECUTABLE=/usr/local/bin/python3 \
                -DRM=/bin/rm \
                -DTAR=/bin/tar \
                -DUNZIP=/usr/local/bin/unzip .."
      system 'samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
