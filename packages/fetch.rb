require 'package'

class Fetch < Package
  description 'FreeBSD Fetch retrieves files by URL.'
  homepage 'https://github.com/jrmarino/fetch-freebsd/'
  version '12.0.10'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/jrmarino/fetch-freebsd.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fetch/12.0.10_armv7l/fetch-12.0.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fetch/12.0.10_armv7l/fetch-12.0.10-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fetch/12.0.10_i686/fetch-12.0.10-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fetch/12.0.10_x86_64/fetch-12.0.10-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cf7304b9e2227a67de69305f7652cf47e8902ab88711115e3abc5b4a1e3dfd48',
     armv7l: 'cf7304b9e2227a67de69305f7652cf47e8902ab88711115e3abc5b4a1e3dfd48',
       i686: '336be94ecea92cadf1b89b00508f2c9678fbda29291c5825f5068589a2b8b39d',
     x86_64: 'fbf71d42114f4b398f6ad0b49917f24710d191e45f9bc3fe4d69fdf5ee27a0ab'
  })

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
      FileUtils.mv "#{CREW_DEST_PREFIX}/lib/*", CREW_DEST_LIB_PREFIX
      FileUtils.rm_r "#{CREW_DEST_PREFIX}/lib/"
    end
  end
end
