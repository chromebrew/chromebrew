require 'package'

class C_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.18.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "cares-#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.18.1_armv7l/c_ares-1.18.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.18.1_armv7l/c_ares-1.18.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.18.1_i686/c_ares-1.18.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.18.1_x86_64/c_ares-1.18.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd2116cf4dc3432f0c14f9c9667e42b10c912c82b95269ab45afe9af5271d6df5',
     armv7l: 'd2116cf4dc3432f0c14f9c9667e42b10c912c82b95269ab45afe9af5271d6df5',
       i686: '1241aa581fae4395c242a79372098d34f640b33c5db9d8e114ad4aa87fc239c2',
     x86_64: '9b7be17a55637cdcb7b956147b15269e0513ca954e298e679afd08ad8b4b17b3'
  })

  depends_on 'glibc' # R

  def self.patch
    system "sed -i 's/1.18.0/#{version}/g' CMakeLists.txt"
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DCARES_STATIC=ON \
      -DCARES_STATIC_PIC=ON \
      -DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON \
      -DCARES_SHARED=ON \
      -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
