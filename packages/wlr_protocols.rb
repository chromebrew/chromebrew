require 'buildsystems/autotools'

class Wlr_protocols < Autotools
  description 'Wayland protocols designed for use in wlroots (and other compositors)'
  homepage 'https://gitlab.freedesktop.org/wlroots/wlr-protocols'
  version '1106a4a'
  license 'Unknown'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/wlroots/wlr-protocols/-/archive/master/wlr-protocols-master.tar.bz2'
  source_sha256 '84f8932b6d645cc0bfc3c10d80a28d800565ebca642f83aedefe6fc4d7e94dbd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '752ea7d6509168b7cb7d83fa2a89eb6e26c5495ec6b9f3586f21338d326abf81',
     armv7l: '752ea7d6509168b7cb7d83fa2a89eb6e26c5495ec6b9f3586f21338d326abf81',
     x86_64: 'c3db6ab13e931a042438e72f3e03096d99dc3f5cf2f3198f5d0bfa7f64f6cc78'
  })

  depends_on 'wayland' => :build
  depends_on 'wlroots' => :logical

  autotools_skip_configure

  def self.patch
    system "sed -i 's,PREFIX=/usr,PREFIX=#{CREW_PREFIX},' Makefile"
  end

  def self.build
    system 'make'
  end
end
