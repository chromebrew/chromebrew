require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  version '4.1-1'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/ccache/ccache/releases/download/v4.1/ccache-4.1.tar.xz'
  source_sha256 '5fdc804056632d722a1182e15386696f0ea6c59cb4ab4d65a54f0b269ae86f99'

  depends_on 'xdg_base'
  depends_on 'asciidoc' => :build

  def self.build
    ENV['CFLAGS'] = '-flto'
    ENV['CXXFLAGS'] = '-flto'
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
      -DZSTD_FROM_INTERNET=ON \
      .."
      system "ninja"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    Dir.chdir 'build' do
      FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/ccache/bin"
      system "for _prog in gcc g++ c++; do
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/$_prog
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/${CHOST}-$_prog
      done
      for _prog in cc clang clang++; do
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/$_prog
      done"

      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
      @env = <<~EOF
        # ccache configuration
        if [ "$PATH" -eq "*ccache/bin*" ]; then
          export PATH="#{CREW_LIB_PREFIX}/ccache/bin:$PATH"
        fi
      EOF
      IO.write("#{CREW_DEST_PREFIX}/etc/env.d/ccache", @env)
    end
  end
end
