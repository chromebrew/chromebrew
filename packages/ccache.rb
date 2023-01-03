require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  @_ver = '4.6.3'
  version @_ver
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{@_ver}/ccache-#{@_ver}.tar.xz"
  source_sha256 '1e3a251bb112632553b8255a78661fe526c3a16598496d51128c32b218fd8b22'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.6.3_armv7l/ccache-4.6.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.6.3_armv7l/ccache-4.6.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.6.3_i686/ccache-4.6.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.6.3_x86_64/ccache-4.6.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '81425bb2430cf6c88dd4b5a7cc391768ee340d388c290c66bad4e6bb8cdee6d9',
     armv7l: '81425bb2430cf6c88dd4b5a7cc391768ee340d388c290c66bad4e6bb8cdee6d9',
       i686: '7d80c4ca1cc5210219e55819b5a8c505c1b6c2ec1868b0c7f844c0ca158870ac',
     x86_64: 'c1db0bb70b6af2544d4026200a93fdf40080b007a6324d75c06455aad2efaef8'
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
      system 'mold -run ninja'
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
      if ! [[ $PATH == *"ccache/bin"* ]]; then
        export PATH="#{CREW_LIB_PREFIX}/ccache/bin:$PATH"
      fi
    CCACHEEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/ccache", @ccacheenv)
  end
end
