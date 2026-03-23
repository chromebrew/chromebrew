require 'buildsystems/cmake'

class Ccache < CMake
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.dev/'
  version '4.13.2'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/ccache/ccache.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5b03a309c204e53e0ba4a435b83568009f6b417974d802ec9f752fcd93c7f45',
     armv7l: 'f5b03a309c204e53e0ba4a435b83568009f6b417974d802ec9f752fcd93c7f45',
       i686: '73c00fd2c44686c07a2bff71e35ad0b7ffe75a0e543daa31a841faef2db94717',
     x86_64: '6a9b4e17d82be9d8e5cfd2452239a05a5b94c23a13f836747586d7e28cd5594c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'xdg_base' => :logical
  depends_on 'xxhash' => :library
  depends_on 'zstd' => :library

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
