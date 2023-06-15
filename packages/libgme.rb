require 'package'

class Libgme < Package
  description 'Blargg\'s video game music file emulation/playback library.'
  homepage 'https://bitbucket.org/mpyne/game-music-emu/'
  version '0.6.3'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://bitbucket.org/mpyne/game-music-emu.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgme/0.6.3_armv7l/libgme-0.6.3-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgme/0.6.3_armv7l/libgme-0.6.3-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgme/0.6.3_i686/libgme-0.6.3-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgme/0.6.3_x86_64/libgme-0.6.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3dd506152d59a392b3e0fd91b568acca67c95178f49b7781c05f9888ade788c8',
      armv7l: '3dd506152d59a392b3e0fd91b568acca67c95178f49b7781c05f9888ade788c8',
        i686: '8d6bdc67ece71fec32b470d57b37507ef55edcbe6807ffa70eff4db1ac3db94e',
      x86_64: 'f87558d76fa56792e156c87cb9db5621f9b2a7ca8cac2f6d9c549761601c79bf'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
