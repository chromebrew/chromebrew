require 'buildsystems/cmake'

class Ccache < CMake
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.dev/'
  version '4.12.2'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/ccache/ccache.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78e9e8b74d4a8f7f73d4e6312f2e28c6e06c43ef2ef19a6691c7466ec64cbaf6',
     armv7l: '78e9e8b74d4a8f7f73d4e6312f2e28c6e06c43ef2ef19a6691c7466ec64cbaf6',
       i686: '435af6439ac81b9ed06d8b84fde565b7b78f8fff663221c946e0378f92ba534b',
     x86_64: '3b06e5a728d712553a7a43b0adf1948f1dabf26923c1944d4884c9d12c21d336'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'xdg_base' # L
  depends_on 'xxhash' # R
  depends_on 'zstd' # R

  print_source_bashrc

  cmake_options "-DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
      -DENABLE_IPO=ON \
      -DENABLE_TESTING=OFF \
      -DZSTD_FROM_INTERNET=OFF \
      -DHIREDIS_FROM_INTERNET=ON"

  cmake_install_extras do
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
