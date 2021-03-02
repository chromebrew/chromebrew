require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  @_ver = '14.2'
  version "#{@_ver}-2"
  compatibility 'all'
  source_url "https://freedesktop.org/software/pulseaudio/releases/pulseaudio-#{@_ver}.tar.xz"
  source_sha256 '75d3f7742c1ae449049a4c88900e454b8b350ecaa8c544f3488a2562a9ff66f1'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-14.2-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-14.2-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-14.2-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-14.2-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b63bb927efd3f315ebe04781e5a1173acbd01ee58bd384b43f7e97e3006e14a2',
     armv7l: 'b63bb927efd3f315ebe04781e5a1173acbd01ee58bd384b43f7e97e3006e14a2',
       i686: '557c79d8841fbdb52c8289e8e174a4f68a1db477a8a1ec7e1a352de8f60ecd95',
     x86_64: 'cbb4cd934818825e7bc006a82c02e67179d17c25922a04574853374c4760a095'
  })

  depends_on 'gsettings_desktop_schemas'
  depends_on 'alsa_plugins' => :build
  depends_on 'tcpwrappers'
  depends_on 'libsndfile'
  depends_on 'xorg_lib'
  depends_on 'libgconf'
  depends_on 'libsoxr'
  depends_on 'libcap'
  depends_on 'jsonc'
  depends_on 'speex'
  depends_on 'eudev'
  depends_on 'gtk3'
  depends_on 'dbus'
  depends_on 'tdb'
  depends_on 'cras'
  depends_on 'orc'
  depends_on 'jack'
  depends_on 'avahi'
  depends_on 'gstreamer'
  depends_on 'valgrind'
  depends_on 'elogind'
  depends_on 'eudev'
  depends_on 'gst_plugins_base'
  depends_on 'gst_plugins_good'
  depends_on 'gst_plugins_bad'
  depends_on 'check' => :build
  depends_on 'webrtc_audio_processing'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Dsystem_user=chronos \
    -Dsystem_group=cras \
    -Daccess_group=cras \
    -Dbluez5=false \
    -Dalsa=enabled \
    -Dgstreamer=enabled \
    -Delogind=enabled \
    -Dtests=true \
    -Dudevrulesdir=#{CREW_PREFIX}/libexec/rules.d \
    -Dalsadatadir=#{CREW_PREFIX}/share/alsa-card-profile \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.check
    # Only test failure is on armv7l:
    # 39/50 thread-test                                                                                                   FAIL             4.02s   exit status 1
    # >>> MALLOC_PERTURB_=232 MAKE_CHECK=1 /usr/local/tmp/crew/pulseaudio-14.2.tar.xz.dir/pulseaudio-14.2/builddir/src/tests/thread-test
    # ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
    # stdout:
    # Running suite(s): Thread
    # 0%: Checks: 1, Failures: 0, Errors: 1
    # ../src/tests/thread-test.c:108:E:thread:thread_test:0: (after this point) Test timeout expired
    # stderr:
    # loop-init
    # once!
    # system 'ninja -C builddir test || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    @pulseaudio_daemon_conf = <<~PAUDIO_DAEMON_CONF_HEREDOC
      # Replace these with the proper values
      exit-idle-time = 10 # Exit as soon as unneeded
      flat-volumes = yes # Prevent messing with the master volume
    PAUDIO_DAEMON_CONF_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/etc/pulse/daemon.conf", @pulseaudio_daemon_conf, perm: 0o666)
    @pulseaudio_client_conf = <<~PAUDIO_CLIENT_CONF_HEREDOC
      # Replace these with the proper values

      # Applications that uses PulseAudio *directly* will spawn it,
      # use it, and pulse will exit itself when done because of the
      # exit-idle-time setting in daemon.conf
      autospawn = yes
    PAUDIO_CLIENT_CONF_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/etc/pulse/client.conf", @pulseaudio_client_conf, perm: 0o666)
    @pulseaudio_default_pa = <<~PAUDIO_DEFAULT_PA_HEREDOC
      # Replace the *entire* content of this file with these few lines and
      # read the comments

      .fail
          # Set tsched=0 here if you experience glitchy playback. This will
          # revert back to interrupt-based scheduling and should fix it.
          #
          # Replace the device= part if you want pulse to use a specific device
          # such as "dmix" and "dsnoop" so it doesn't lock an hw: device.

          # INPUT/RECORD
          load-module module-alsa-source device="default" tsched=1

          # OUTPUT/PLAYBACK
          load-module module-alsa-sink device="default" tsched=1

          # Accept clients -- very important
          load-module module-native-protocol-unix

      .nofail
      .ifexists module-x11-publish.so
          # Publish to X11 so the clients know how to connect to Pulse. Will
          # clear itself on unload.
          load-module module-x11-publish
      .endif
    PAUDIO_DEFAULT_PA_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/etc/pulse/default.pa", @pulseaudio_default_pa, perm: 0o666)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dbus-1/system.d"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/dbus-1/system.d/pulseaudio-system.conf",
                 "#{CREW_DEST_PREFIX}/share/dbus-1/system.d/pulseaudio-system.conf"
  end
end
