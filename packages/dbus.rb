require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.15.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/dbus/dbus.git'
  git_hashtag "dbus-#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dbus/1.15.4_armv7l/dbus-1.15.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dbus/1.15.4_armv7l/dbus-1.15.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dbus/1.15.4_i686/dbus-1.15.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dbus/1.15.4_x86_64/dbus-1.15.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3e8cb13e7c1e6bb23067f0def5eb33c1fb042b99eac3654a2a02a64cd52d5f59',
     armv7l: '3e8cb13e7c1e6bb23067f0def5eb33c1fb042b99eac3654a2a02a64cd52d5f59',
       i686: 'd48d4149c92bef9981515ce47a4491123013b855147290f358126e18d1e5d4b7',
     x86_64: 'fc1c818d773ece8193082dca1203878e8382a3fb17d7c6cd32a1f29d9f4788e4'
  })

  depends_on 'libice' => :build
  depends_on 'libsm' => :build
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libx11' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Dapparmor=disabled \
      -Ddbus_session_bus_listen_address=unix:tmpdir=/tmp \
      -Ddoxygen_docs=disabled \
      -Dlibaudit=disabled \
      -Dlaunchd=disabled \
      -Dxml_docs=disabled \
      -Druntime_dir=/var \
      -Dsystemd=disabled \
      -Dx11_autolaunch=enabled \
       builddir"
    system 'meson configure --no-pager builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @dbusconfigenv = <<~DBUSCONFIGEOF
      # Dbus settings
      DBUS_SYSTEM_BUS_ADDRESS='unix:path=/var/run/dbus/system_bus_socket'
      [[ "$DBUS_SESSION_BUS_ADDRESS"=="disabled:" ]] && unset DBUS_SESSION_BUS_ADDRESS
      if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
        # if not found, launch a new one
        eval `dbus-launch --sh-syntax`
        # echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
      fi
      dbus-update-activation-environment --all
    DBUSCONFIGEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/dbus", @dbusconfigenv)
  end

  def self.postinstall
    FileUtils.rm_f "#{CREW_PREFIX}/etc/env.d/03-dbus" if File.file?("#{CREW_PREFIX}/etc/env.d/03-dbus")
  end
end
