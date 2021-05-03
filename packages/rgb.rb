require 'package'

class Rgb < Package
  description 'X color name database'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.6'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/rgb-1.0.6.tar.bz2'
  source_sha256 'bbca7c6aa59939b9f6a0fb9fff15dfd62176420ffd4ae30c8d92a6a125fbe6b0'

  depends_on 'xorg_proto' => :build

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
