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
    aarch64: 'b786b083fcf3ccfff06878ea9aae4241f7b2262fa0fab7b9c9fff0c22f9283d1',
     armv7l: 'b786b083fcf3ccfff06878ea9aae4241f7b2262fa0fab7b9c9fff0c22f9283d1',
       i686: '4a62a2b027b4df4db1fa22796e60e254036ed50dc87041c396a6b31b273d6661',
     x86_64: 'f7d86117e3c85d948ae5b679631c4a3a363784e47cc52ad11abbd3092842b66f'
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
