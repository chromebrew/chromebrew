require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  version '4.2.1'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/ccache/ccache/releases/download/v4.2.1/ccache-4.2.1.tar.xz'
  source_sha256 '9d6ba1cdefdc690401f404b747d81a9a1802b17af4235815866b7620d980477e'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ccache-4.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ccache-4.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/ccache-4.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/ccache-4.2.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'abe2f4a839d98bf3946c59f731090a02f2436b832685fd7bbf4a952a54537b16',
     armv7l: 'abe2f4a839d98bf3946c59f731090a02f2436b832685fd7bbf4a952a54537b16',
       i686: '1be1b4baeb1885eedab0e3faddce5cda98921195a14b9523c222f97a27ddfc9f',
     x86_64: 'b0ba3c720acaaa3a88af3ac5266aa1370b5a4ccf4fa9861d917b745ee337d023'
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
        if [ "\$PATH" -eq "*ccache/bin*" ]; then
          export PATH="#{CREW_LIB_PREFIX}/ccache/bin:\$PATH"
        fi
      CCACHEEOF
      IO.write("#{CREW_DEST_PREFIX}/etc/env.d/ccache", @ccacheenv)
    end
  end
end
