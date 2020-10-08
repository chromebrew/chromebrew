require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipwire.org'
  version '0.3.13'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/0.3.13/pipewire-0.3.13.tar.gz'
  source_sha256 '40f2db86d8ba14706bfab8ee7c1789aeeb72bee386d1e44dbcd98888ef9861e5'

  depends_on 'gsettings_desktop_schemas'
  depends_on 'alsa_plugins' => :build
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on "jack"
  depends_on 'llvm' => :build

  def self.build
     ENV['CFLAGS'] = "-fuse-ld=lld"
     ENV['CXXFLAGS'] = "-fuse-ld=lld"
     system "meson",
     "--prefix=#{CREW_PREFIX}",
     "--libdir=#{CREW_LIB_PREFIX}",
      "-Dbluez5=false",
      "-Dbluez5-backend-native=false",
      "-Dbluez5-backend-ofono=false",
      "-Dbluez5-backend-hsphfpd=false",
      "-Dvulkan=false",
      "build"
  end

  def self.install
     system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

end
