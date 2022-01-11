require 'package'

class Libgme < Package
  description 'Blargg\'s video game music file emulation/playback library.'
  homepage 'https://bitbucket.org/mpyne/game-music-emu/'
  @_ver = '0.6.3'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://bitbucket.org/mpyne/game-music-emu.git'
  git_hashtag @_ver

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
