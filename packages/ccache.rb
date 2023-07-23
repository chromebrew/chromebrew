require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  version '4.8.2'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{version}/ccache-#{version}.tar.xz"
  source_sha256 '3d3fb3f888a5b16c4fa7ee5214cca76348afd6130e8443de5f6f2424f2076a49'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.8.2_armv7l/ccache-4.8.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.8.2_armv7l/ccache-4.8.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.8.2_i686/ccache-4.8.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.8.2_x86_64/ccache-4.8.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '279ee8b2baba8170657f548d0dfef3754acd0dc9c3c58c91a689ef1135ed9f5a',
     armv7l: '279ee8b2baba8170657f548d0dfef3754acd0dc9c3c58c91a689ef1135ed9f5a',
       i686: '84eee2802132145654a3e32d16702d502e0e2d8e474322555e251dce37ecb452',
     x86_64: '3df947b2666aea7f86b1399211799ea182f1a6d5b74d635e8589fff050521bec'
  })

  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'xdg_base'
  depends_on 'zstd' # R

  def self.build
    system "cmake -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
      -DENABLE_IPO=ON \
      -DENABLE_TESTING=OFF \
      -DZSTD_FROM_INTERNET=OFF \
      -DHIREDIS_FROM_INTERNET=ON"
    system "#{CREW_NINJA} -C builddir"
    File.write 'ccache_env', <<~CCACHEEOF
      # ccache configuration
      if [[ $PATH != *"ccache/bin"* ]]; then
        PATH="#{CREW_LIB_PREFIX}/ccache/bin:$PATH"
      fi
    CCACHEEOF
  end

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
    FileUtils.install 'ccache_env', "#{CREW_DEST_PREFIX}/etc/env.d/00-ccache", mode: 0o644
  end
end
