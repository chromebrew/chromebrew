require 'package'

class Zziplib < Package
  description 'The ZZIPlib provides read access on ZIP-archives and unpacked data.'
  homepage 'http://zziplib.sourceforge.net/'
  version '0.13.72'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gdraheim/zziplib/archive/refs/tags/v0.13.72.tar.gz'
  source_sha256 '93ef44bf1f1ea24fc66080426a469df82fa631d13ca3b2e4abaeab89538518dc'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '2670ba6fa4866b63fd6e70070a169e530355ccc66938189ac9b679a2d9fb4f92',
     armv7l: '2670ba6fa4866b63fd6e70070a169e530355ccc66938189ac9b679a2d9fb4f92',
       i686: '2e80d0c5286bf3fdaa1b8e1e2a03aefc34c979c716eb89098d855973e5fcc94d',
     x86_64: 'cf37a998b62be10582f351b78173f87788a9006deb31bb4fed0cfe63d50e3fc3'
  })

  depends_on 'samurai' => :build
  depends_on 'xmlto' => :build

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env #{CREW_ENV_OPTIONS} \
        cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
        -DCP=/bin/cp \
        -DGZIP=/bin/gzip \
        -DMKZIP=#{CREW_PREFIX}/bin/zip \
        -DMV=/bin/mv \
        -DPKG_CONFIG_EXECUTABLE=#{CREW_PREFIX}/bin/pkg-config \
        -DPYTHON_EXECUTABLE=/usr/local/bin/python3 \
        -DRM=/bin/rm \
        -DTAR=/bin/tar \
        -DUNZIP=#{CREW_PREFIX}/bin/unzip .."
      system 'samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
