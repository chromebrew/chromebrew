require 'package'

class Cracklib < Package
  description 'The CrackLib package contains a library used to enforce strong passwords by comparing user selected passwords to words in chosen word lists.'
  homepage 'https://github.com/cracklib/cracklib'
  version '2.10.3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/cracklib/cracklib.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26f166493cc8af576ac1c0a101d7fead20aa211f7da59a19349446bd814fbc8d',
     armv7l: '26f166493cc8af576ac1c0a101d7fead20aa211f7da59a19349446bd814fbc8d',
       i686: '2decf564080f0f40515ac4cf11f93129dd0ba8852d45e01fc59ddadc360d3973',
     x86_64: 'a44522bfeaa1a8247e686c05b9b11d394cbe7d673105ebae9b1348c9c0edf17e'
  })

  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  def self.build
    Dir.chdir 'src' do
      system './autogen.sh'
      system "./configure \
              --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              --disable-static"
    end
  end

  def self.install
    Dir.chdir 'src' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.test
    Dir.chdir 'src' do
      system 'make test'
    end
  end
end
