require 'package'

class Cracklib < Package
  description 'The CrackLib package contains a library used to enforce strong passwords by comparing user selected passwords to words in chosen word lists.'
  homepage 'https://github.com/cracklib/cracklib'
  version '2.10.4-gpg'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/cracklib/cracklib.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82cfcc16986a7d3f96224219e373fd86e0a6827719cde41fd042f1c09f8f6982',
     armv7l: '82cfcc16986a7d3f96224219e373fd86e0a6827719cde41fd042f1c09f8f6982',
       i686: '51dc05d64081ad932a7e228830d7d3c83476b5e12a6fd244092f83d7d1b9e9e4',
     x86_64: '2e9ecdcf0785a4ba5aa6910ed76d05beff21ece6f1cc5eadc10cbddb75fdbf77'
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
