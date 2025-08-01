require 'buildsystems/meson'

class Dbus < Meson
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.16.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/dbus/dbus.git'
  git_hashtag "dbus-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a59af1d22ad1a8c7124ad4c5eb123196d84c47040226d0556c969edc3a560d58',
     armv7l: 'a59af1d22ad1a8c7124ad4c5eb123196d84c47040226d0556c969edc3a560d58',
       i686: 'f55865c5c6f8ba1f2cc3651debc1e848d6f703adeabdce3125eac3b9684baa81',
     x86_64: 'c28c9fbda77f5125d6201cb164a8e94842fbaf32eec3a871b636e3ec239b3112'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libice' => :build unless ARCH == 'i686'
  depends_on 'libsm' => :build unless ARCH == 'i686'
  depends_on 'libx11' unless ARCH == 'i686' # R

  print_source_bashrc

  meson_options "-Dapparmor=disabled \
      -Ddbus_session_bus_listen_address='unix:path=/var/run/dbus/system_bus_socket' \
      -Ddoxygen_docs=disabled \
      -Dlibaudit=disabled \
      -Dlaunchd=disabled \
      -Dxml_docs=disabled \
      -Druntime_dir=/var/run \
      -Dsystemd=disabled \
      -Dx11_autolaunch=#{ARCH == 'i686' ? 'disabled' : 'enabled'}"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    @dbusconfigenv = <<~DBUSCONFIGEOF
      # Dbus settings
      [[ -d '/var/run/dbus' ]] || ( sudo mkdir -p /var/run/dbus && sudo chown chronos /var/run/dbus )
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
