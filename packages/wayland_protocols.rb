require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.17'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.17.tar.xz'
  source_sha256 'df1319cf9705643aea9fd16f9056f4e5b2471bd10c0cc3713d4a4cdc23d6812f'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
