require 'buildsystems/cmake'

class Ccache < CMake
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  version '4.9.1'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{version}/ccache-#{version}.tar.xz"
  source_sha256 '4c03bc840699127d16c3f0e6112e3f40ce6a230d5873daa78c60a59c7ef59d25'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd54bd2f5b30ca8c3f706ea7a95156a2507ac14b05ca515af25c7632985c3d9a1',
     armv7l: 'd54bd2f5b30ca8c3f706ea7a95156a2507ac14b05ca515af25c7632985c3d9a1',
       i686: '3af6ca8bb0e136e737554172dceb98709a2548361f734879c084f0939079a527',
     x86_64: '4f99d28cd4ec2e6931bd45b98f275c1fb3686f9c09aee7f34aa9ca05d32c1974'
  })

  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'xdg_base'
  depends_on 'zstd' # R

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
