require 'package'

class Libcue < Package
  description 'Parses so-called cue sheets and handles the parsed data.'
  homepage 'https://github.com/lipnitsk/libcue/'
  @_ver = '2.2.1'
  version @_ver + '-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lipnitsk/libcue.git'
  git_hashtag 'v' + @_ver

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

  def self.check
    system 'samu -C builddir test'
  end
end
