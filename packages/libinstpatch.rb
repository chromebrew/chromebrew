require 'package'

class Libinstpatch < Package
  description 'libInstPatch is a library for processing digital sample based MIDI instrument "patch" files.'
  homepage 'https://github.com/swami/libinstpatch/'
  version '1.1.6'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://github.com/swami/libinstpatch.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinstpatch/1.1.6_armv7l/libinstpatch-1.1.6-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinstpatch/1.1.6_armv7l/libinstpatch-1.1.6-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinstpatch/1.1.6_i686/libinstpatch-1.1.6-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinstpatch/1.1.6_x86_64/libinstpatch-1.1.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b7a7e8bec56017428e7aa7ebf630b6ca60ccaec4a3675d3d10c5cb9d89e13a9f',
      armv7l: 'b7a7e8bec56017428e7aa7ebf630b6ca60ccaec4a3675d3d10c5cb9d89e13a9f',
        i686: '881717a4dac1023bd5819f2af363b5185ef05dda0d6bc8edc9a23ea193fc929f',
      x86_64: '8a53448ff86a653799bdcf65965e32c726a1fc6ba8aeaefea7a33ee76ef95cfa'
  })

  depends_on 'glib'
  depends_on 'libsndfile'

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
