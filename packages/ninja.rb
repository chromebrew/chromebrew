require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.11.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja/archive/v1.11.1.tar.gz'
  source_sha256 '31747ae633213f1eda3842686f83c2aa1412e0f5691d1c14dbbcc67fe7400cea'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.1_armv7l/ninja-1.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.1_armv7l/ninja-1.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.1_i686/ninja-1.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.1_x86_64/ninja-1.11.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ff439c9f733c638cbfb37602ec31775ab8102f927e7c26b57b3bedd2a30c725d',
     armv7l: 'ff439c9f733c638cbfb37602ec31775ab8102f927e7c26b57b3bedd2a30c725d',
       i686: 'ffa46259484a0a86c92010b3cc62867fb2cff0862c9e2ce17723d8318b9ce635',
     x86_64: '96cad814e005ffb14a47a01bb7bf61971cc1890439e879444f04bf88f5083886'
  })

  depends_on 're2c' => :build
  depends_on 'samurai' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # Handle issue with re2c: error: cannot rename or write temporary file
      # ninja-1.11.1/builddir/lexer.cc to output file ninja-1.11.1/builddir/lexer.cc
      # https://github.com/skvadrik/re2c/issues/417
      if ARCH == 'x86_64'
        @files = %w[lexer.cc depfile_parser.cc]
        @files.each do |file|
          FileUtils.touch file
        end
      end
      system "mold -run cmake \
          #{CREW_CMAKE_OPTIONS} \
          -Wdev \
          -G Ninja \
          .."
      system 'mold -run samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
