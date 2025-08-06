require 'buildsystems/cmake'

class Ccache < CMake
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.dev/'
  version '4.11.3'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{version}/ccache-#{version}.tar.xz"
  source_sha256 '4c03bc840699127d16c3f0e6112e3f40ce6a230d5873daa78c60a59c7ef59d25'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a41d406641063b63398997b8d2c33142316952f545233c5a0fe9427cded81349',
     armv7l: 'a41d406641063b63398997b8d2c33142316952f545233c5a0fe9427cded81349',
       i686: '7ea6be760b129c51437a4cee5f54618803323e9e0f7e451630184e77002a430f',
     x86_64: '9ea1c743be382dc68eb61e59dfd0aa490796b546ee72f99068212cfa3b7f4ca3'
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
