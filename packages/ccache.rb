require 'buildsystems/cmake'

class Ccache < CMake
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.dev/'
  version '4.11.2'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{version}/ccache-#{version}.tar.xz"
  source_sha256 '4c03bc840699127d16c3f0e6112e3f40ce6a230d5873daa78c60a59c7ef59d25'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b3fc2986772cdc20d4216c7b73d777f58dff257685109c16e3d82b1d8ec1e7d',
     armv7l: '4b3fc2986772cdc20d4216c7b73d777f58dff257685109c16e3d82b1d8ec1e7d',
       i686: '680d3e26b12348908619b5d36a52fe4a4f3300923ce0db10a43289323e5824e8',
     x86_64: '4f733a2737d3b454b8cbeef3c4f9a4d6075275b31206e734c768becffa29fa41'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'xdg_base'
  depends_on 'xxhash' # R
  depends_on 'zstd' # R

  print_source_bashrc

  cmake_options "-DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
      -DENABLE_IPO=ON \
      -DENABLE_TESTING=OFF \
      -DZSTD_FROM_INTERNET=OFF \
      -DHIREDIS_FROM_INTERNET=ON"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/ccache/bin"
    Dir.chdir "#{CREW_DEST_LIB_PREFIX}/ccache/bin" do
      %w[gcc g++ c++].each do |bin|
        FileUtils.ln_s '../../../bin/ccache', bin
      end
      %w[cc clang clang++].each do |bin|
        FileUtils.ln_s '../../../bin/ccache', bin
      end
    end
    File.write 'ccache_env', <<~CCACHEEOF
      # ccache configuration
      if [[ $PATH != *"ccache/bin"* ]]; then
        PATH="#{CREW_LIB_PREFIX}/ccache/bin:$PATH"
      fi
    CCACHEEOF
    FileUtils.install 'ccache_env', "#{CREW_DEST_PREFIX}/etc/env.d/00-ccache", mode: 0o644
  end
end
