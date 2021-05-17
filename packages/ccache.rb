require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  @_ver = '4.3'
  version @_ver
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{@_ver}/ccache-#{@_ver}.tar.xz"
  source_sha256 '504a0f2184465c306826f035b4bc00bae7500308d6af4abbfb50e33a694989b4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.3_armv7l/ccache-4.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.3_armv7l/ccache-4.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.3_i686/ccache-4.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.3_x86_64/ccache-4.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'abda944f6994dbd35338ad1cf124642f907c9dc37ea218843db6a20a635ccaef',
     armv7l: 'abda944f6994dbd35338ad1cf124642f907c9dc37ea218843db6a20a635ccaef',
       i686: '2b26758218334508e45aedbea916996dfefc5b414de8a6f1079523954a5f6982',
     x86_64: '5b2cc2ccebe97eb2212091d478ac5168e4eddf887a1374cca2b5d566f142c40d'
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
