require 'buildsystems/meson'

class Pipewire < Meson
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  version '1.6.4'
  compatibility 'aarch64 armv7l x86_64'
  license 'LGPL-2.1+'
  source_url 'https://gitlab.freedesktop.org/pipewire/pipewire.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e614a7f040d6421e2a762bd072ece62d9ad2fa76bcfe8d4fcdbd22049c5be5a4',
     armv7l: 'e614a7f040d6421e2a762bd072ece62d9ad2fa76bcfe8d4fcdbd22049c5be5a4',
     x86_64: 'b89b4c84bd07660d6a5835c06b6010f5026b3aec936283f632c7aa74e0d9e09a'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'alsa_plugins' => :build
  depends_on 'avahi' => :library
  depends_on 'ca_certificates' => :build
  depends_on 'dbus' => :library
  depends_on 'elogind' => :build
  depends_on 'eudev' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gstreamer' => :library
  depends_on 'gstreamer' => :logical
  depends_on 'jack' => :library
  depends_on 'libdrm' => :library
  depends_on 'libmysofa' => :library
  depends_on 'libsndfile' => :library
  depends_on 'lilv' => :library
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :library
  depends_on 'opus' => :library
  depends_on 'pulseaudio' => :library
  depends_on 'py3_lxml' => :build
  depends_on 'readline' => :executable
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :library
  depends_on 'webrtc_audio_processing' => :library

  def self.prebuild
    # Without running the ca_certificates postinstall armv7l build breaks
    # complaining about the network not working.
    system "#{CREW_PREFIX}/bin/update-ca-certificates --fresh --certsconf #{CREW_PREFIX}/etc/ca-certificates.conf"
  end

  # -lpthread is needed for pre-Glibc 2.30 with the c11threads package.
  pre_meson_options "CC='gcc -lpthread' CXX='g++ -lpthread' LDFLAGS='#{CREW_LINKER_FLAGS} -pthread'"
  meson_options "-Dbluez5-backend-hsphfpd=disabled \
      -Dbluez5-backend-ofono=disabled \
      -Dbluez5=disabled \
      -Dexamples=disabled \
      -Dsession-managers=[] \
      -Dtest=disabled \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d \
      -Dv4l2=disabled \
      -Dvolume=auto \
      -Dvulkan=enabled"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    Dir.chdir("#{CREW_DEST_PREFIX}/include") do
      FileUtils.ln_sf 'spa-0.2/spa', 'spa'
      FileUtils.ln_sf 'pipewire-0.3/pipewire', 'pipewire'
    end
  end
end
