require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  @_ver = '4.4.1'
  version @_ver
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{@_ver}/ccache-#{@_ver}.tar.xz"
  source_sha256 'ebd6dfb5b15dfe39310e1f5834bafbe6ab526c71df8ad08a508e8a242bad8159'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.4.1_i686/ccache-4.4.1-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.4.1_armv7l/ccache-4.4.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.4.1_armv7l/ccache-4.4.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.4.1_x86_64/ccache-4.4.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: '6a1585edc95b2aa73bea3c44aa8ac7a9c9a51f5b4ada9b082678aebd2a6f3aa8',
    aarch64: '87280c39170a39a8eb1e0af251d464d99820db4d034f5fd262aa2e5d1ba5c08e',
     armv7l: '87280c39170a39a8eb1e0af251d464d99820db4d034f5fd262aa2e5d1ba5c08e',
     x86_64: 'ca97449d2ffb651915de4c0f1472e5f0db3dc2d85dd009b3c241ba67fc93febd'
  })

  depends_on 'xdg_base'
  depends_on 'asciidoc' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "env #{CREW_ENV_OPTIONS} \
      cmake -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
      -DZSTD_FROM_INTERNET=ON \
      -DHIREDIS_FROM_INTERNET=ON \
      .."
      system 'ninja'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/ccache/bin"
    @gcc_bins = %w[gcc g++ c++]
    @llvm_bins = %w[cc clang clang++]
    Dir.chdir "#{CREW_DEST_LIB_PREFIX}/ccache/bin" do
      @gcc_bins.each do |bin|
        FileUtils.ln_s '../../../bin/ccache', bin
      end
      @llvm_bins.each do |bin|
        FileUtils.ln_s '../../../bin/ccache', bin
      end
    end
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
