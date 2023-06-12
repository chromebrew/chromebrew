require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  version '4.7.4'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url "https://github.com/ccache/ccache/releases/download/v#{version}/ccache-#{version}.tar.xz"
  source_sha256 'df0c64d15d3efaf0b4f6837dd6b1467e40eeaaa807db25ce79c3a08a46a84e36'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.7.4_armv7l/ccache-4.7.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.7.4_armv7l/ccache-4.7.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.7.4_i686/ccache-4.7.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ccache/4.7.4_x86_64/ccache-4.7.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '29e5721a8ae9cbe2cb60e2cf7f7f04021c259c832f4622288cda1f96273d2e5c',
     armv7l: '29e5721a8ae9cbe2cb60e2cf7f7f04021c259c832f4622288cda1f96273d2e5c',
       i686: '6b0c3062486bcb56b1be202dc477113fa61eaf3e596d228db8dbfd3509db3792',
     x86_64: '195ba7619b377aa52a59511b62e9bfe7e34ae463dd0662ca2870b9743fd1a5f1'
  })

  depends_on 'xdg_base'
  depends_on 'ruby_asciidoctor' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
      -DZSTD_FROM_INTERNET=ON \
      -DHIREDIS_FROM_INTERNET=ON \
      .."
      system 'mold -run ninja'
    end
    @ccacheenv = <<~CCACHEEOF
      # ccache configuration
      if [[ $PATH != *"ccache/bin"* ]]; then
        PATH="#{CREW_LIB_PREFIX}/ccache/bin:$PATH"
      fi
    CCACHEEOF
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/ccache/bin"
    Dir.chdir "#{CREW_DEST_LIB_PREFIX}/ccache/bin" do
      %w[gcc g++ c++].each do |bin|
        FileUtils.ln_s '../../../bin/ccache', bin
      end
      %w[cc clang clang++].each do |bin|
        FileUtils.ln_s '../../../bin/ccache', bin
      end
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/00-ccache", @ccacheenv)
  end
end
