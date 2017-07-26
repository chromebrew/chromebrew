require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients'
  homepage 'https://wayland.freedesktop.org'
  version '1.9'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.9.tar.xz'
  source_sha256 '666b72de30ca3b70c2b54ccc9e8114cb520e76db224c816b5e23501099174f75'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
