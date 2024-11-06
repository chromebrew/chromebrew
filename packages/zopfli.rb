require 'package'

class Zopfli < Package
  description 'A very good, but slow, deflate or zlib compression.'
  homepage 'https://github.com/google/zopfli/'
  version '1.0.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/zopfli.git'
  git_hashtag "zopfli-#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '0df215ad8248545623199d63fabc4ca34962fce0c7aa713b3294cef8da824de4',
     armv7l: '0df215ad8248545623199d63fabc4ca34962fce0c7aa713b3294cef8da824de4',
       i686: 'd8247dde07c470fa307c5fbb31a8b3d08f4a1d75d42dacd4f1f12540134c6873',
     x86_64: 'de21437eb8fefa57c8f62928fe1d25e940bc3a9d9d1f57438a4e6628294d6a8a'
  })

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
