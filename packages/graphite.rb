require 'package'

class Graphite < Package
  description 'Reimplementation of the SIL Graphite text processing engine'
  homepage 'https://github.com/silnrsi/graphite'
  version '425da3d'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/silnrsi/graphite.git'
  git_hashtag '425da3d08926b9cf321fc0014dfa979c24d2cf64'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/425da3d_armv7l/graphite-425da3d-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/425da3d_armv7l/graphite-425da3d-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/425da3d_i686/graphite-425da3d-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/425da3d_x86_64/graphite-425da3d-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '94516aa9980b775d1134a8d1ccdfc22cc1cfe205214da799d725ddbb23994968',
     armv7l: '94516aa9980b775d1134a8d1ccdfc22cc1cfe205214da799d725ddbb23994968',
       i686: '085fdc5fd0b57b89d924bee3db23499cdb2804351e4da10830f6b99fe8dd5ba8',
     x86_64: '7731c7c3bfc32f76f80294621cc1b37cb1270828bc1f80c0226f44e9f28abce7'
  })

  def self.patch
    # remove font tools dependent tests
    system "sed -i '/cmptest/d' tests/CMakeLists.txt"
  end

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake #{CREW_CMAKE_LIBSUFFIX_OPTIONS} .."
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
