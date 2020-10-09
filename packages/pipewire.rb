require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipwire.org'
  version '0.3.13'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/0.3.13/pipewire-0.3.13.tar.gz'
  source_sha256 '40f2db86d8ba14706bfab8ee7c1789aeeb72bee386d1e44dbcd98888ef9861e5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.13-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3bc0dc8a59bd16789b238f9e093660ab4d81ba7e821a8d83bb755cc5cb528ce2',
     armv7l: '3bc0dc8a59bd16789b238f9e093660ab4d81ba7e821a8d83bb755cc5cb528ce2',
     x86_64: '259eedde6d48d78c87528ee31be78b55debb254e9cd40f662f192e608f000c1b',
  })

  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    depends_on 'gsettings_desktop_schemas'
    depends_on 'alsa_plugins' => :build
    depends_on 'gst_plugins_base'
    depends_on 'gstreamer'
    depends_on 'jack'
  end

  def self.build
     #ENV['CFLAGS'] = "-fuse-ld=lld"
     #ENV['CXXFLAGS'] = "-fuse-ld=lld"
     system "meson",
     "--prefix=#{CREW_PREFIX}",
     "--libdir=#{CREW_LIB_PREFIX}",
     '-Dbluez5=false',
     '-Dbluez5-backend-native=false',
     '-Dbluez5-backend-ofono=false',
     '-Dbluez5-backend-hsphfpd=false',
     '-Dvulkan=false',
     'build'
  end

  def self.install
     system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

end
