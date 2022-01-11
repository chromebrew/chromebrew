require 'package'

class Libmysofa < Package
  description 'libmysofa is a reader for AES SOFA files to get better HRTFs.'
  homepage 'https://github.com/hoene/libmysofa/'
  @_ver = '1.2.1'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hoene/libmysofa.git'
  git_hashtag 'v' + @_ver

  depends_on 'cunit'

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
