require 'package'

class Pupnp < Package
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  @_ver = '1.14.12'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag 'release-' + @_ver

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
