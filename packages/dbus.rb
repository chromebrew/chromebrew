require 'buildsystems/meson'

class Dbus < Meson
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.15.8'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/dbus/dbus.git'
  git_hashtag "dbus-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f1f77718901fc0d1088ab0c4640b7cbef43b7c86608738cb0516ab7ba6ad9a9',
     armv7l: '5f1f77718901fc0d1088ab0c4640b7cbef43b7c86608738cb0516ab7ba6ad9a9',
     x86_64: '2d3738efe15084a4c5b212deefc8fe6d961f69842b4e1efdaf1c0ac3613fda17'
  })

  depends_on 'libice' => :build
  depends_on 'libsm' => :build
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libx11' # R

  print_source_bashrc

  meson_options "-Dapparmor=disabled \
      -Ddbus_session_bus_listen_address=unix:tmpdir=/tmp \
      -Ddoxygen_docs=disabled \
      -Dlibaudit=disabled \
      -Dlaunchd=disabled \
      -Dxml_docs=disabled \
      -Druntime_dir=/var \
      -Dlocalstatedir=#{CREW_PREFIX}/var \
      -Dsystemd=disabled \
      -Dx11_autolaunch=enabled"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    @dbusconfigenv = <<~DBUSCONFIGEOF
      # Dbus settings
      dbus-uuidgen --ensure
      DBUS_SYSTEM_BUS_ADDRESS='unix:path=/var/run/dbus/system_bus_socket'
      [[ "$DBUS_SESSION_BUS_ADDRESS"=="disabled:" ]] && unset DBUS_SESSION_BUS_ADDRESS
      if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
        # if not found, launch a new one
        eval `dbus-launch --sh-syntax`
        # echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
      fi
      dbus-update-activation-environment --all
    DBUSCONFIGEOF
    File.write('env.d_dbus', @dbusconfigenv)
    FileUtils.install 'env.d_dbus', "#{CREW_DEST_PREFIX}/etc/env.d/dbus", mode: 0o644
  end

  def self.postinstall
    FileUtils.rm_f "#{CREW_PREFIX}/etc/env.d/03-dbus" if File.file?("#{CREW_PREFIX}/etc/env.d/03-dbus")
  end
end
