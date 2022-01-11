require 'package'

class Libinstpatch < Package
  description 'libInstPatch is a library for processing digital sample based MIDI instrument "patch" files.'
  homepage 'https://github.com/swami/libinstpatch/'
  @_ver = '1.1.6'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/swami/libinstpatch.git'
  git_hashtag 'v' + @_ver

  depends_on 'glib'

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
