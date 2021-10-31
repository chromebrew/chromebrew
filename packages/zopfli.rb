require 'package'

class Zopfli < Package
  description 'A very good, but slow, deflate or zlib compression.'
  homepage 'https://github.com/google/zopfli/'
  @_ver = '1.0.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/zopfli.git'
  git_hashtag 'zopfli-' + @_ver

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "#{CREW_ENV_OPTIONS} cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
            -DZOPFLI_BUILD_SHARED=ON .."
      system 'samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
