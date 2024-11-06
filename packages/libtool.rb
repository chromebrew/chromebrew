require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.5.3'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libtool/libtool-#{version}.tar.xz"
  source_sha256 '898011232cc59b6b3bbbe321b60aba9db1ac11578ab61ed0df0299458146ae2e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4bf53b273b5e90c4a3470d878b94f2de531ae8140ca460e28ca87664a5510ab',
     armv7l: 'a4bf53b273b5e90c4a3470d878b94f2de531ae8140ca460e28ca87664a5510ab',
       i686: '86f4cfa7180133de85327171f111e5728ab2431503b708aec781ce77bd4cf013',
     x86_64: '72cecefe0089d7befb386b8df1b4608a5c6c987576e6f35d162a78a2743f76ca'
  })

  depends_on 'm4'

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
            --enable-ltdl-install"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # Some tests fail on arm builds.
    # Link order of deplibs             FAILED (link-order2.at:126)
    # static linking flags for programs FAILED (static.at:177)
    # Run tests with low max_cmd_len    FAILED (cmdline_wrap.at:48)
    system 'make', 'check'
  end
end
