require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  @_ver = '4.2.1'
  version "#{@_ver}-1"
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{@_ver}/ccache-#{@_ver}.tar.xz"
  source_sha256 '9d6ba1cdefdc690401f404b747d81a9a1802b17af4235815866b7620d980477e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.2.1-1_armv7l/ccache-4.2.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.2.1-1_armv7l/ccache-4.2.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.2.1-1_i686/ccache-4.2.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.2.1-1_x86_64/ccache-4.2.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4198dda721970ec84c1a02fcd792cbf6c54afb8e6d48a8b0b39335030a79ce40',
     armv7l: '4198dda721970ec84c1a02fcd792cbf6c54afb8e6d48a8b0b39335030a79ce40',
       i686: '44ad63eb78b3fbe0973276d4724d97e0512ae42fd0b881a6825da8259584a15e',
     x86_64: '1c063513b2fb098399ad94d8818d04d0eae4569ae1846411d2f421a5567bccca'
  })

  depends_on 'xdg_base'
  depends_on 'asciidoc' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "env CFLAGS='-flto' CXXFLAGS='-flto' \
      cmake -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
      -DZSTD_FROM_INTERNET=ON \
      .."
      system 'ninja'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    Dir.chdir 'build' do
      FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/ccache/bin"
      system "for _prog in gcc g++ c++; do
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/$_prog
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/#{CREW_TGT}-$_prog
      done
      for _prog in cc clang clang++; do
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/$_prog
      done"

      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
      @ccacheenv = <<~CCACHEEOF
        # ccache configuration
        if ! [[ \$PATH == *"ccache/bin"* ]]; then
          export PATH="#{CREW_LIB_PREFIX}/ccache/bin:\$PATH"
        fi
      CCACHEEOF
      IO.write("#{CREW_DEST_PREFIX}/etc/env.d/ccache", @ccacheenv)
    end
  end
end
