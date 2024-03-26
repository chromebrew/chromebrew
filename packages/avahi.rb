require 'buildsystems/autotools'

class Avahi < Autotools
  description 'Avahi is a system which facilitates service discovery on a local network via the mDNS/DNS-SD protocol suite.'
  homepage 'http://www.avahi.org/'
  version '0.9-rc1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/avahi/avahi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '2b2877cd51f371021961ce9b461175788eb8bc5b9fb526d2985156d78817f02b',
    aarch64: '55a7a9c8e8e80a953b1d76baa11f3be6de995a967d2b767d35d2e2c9283070f2',
     armv7l: '55a7a9c8e8e80a953b1d76baa11f3be6de995a967d2b767d35d2e2c9283070f2',
     x86_64: '49d0133ff649c3ec5d8673c7ec0cbd0c1b0ab31c49d43712d2dd3dbe92a948f5'
  })

  depends_on 'expat' # R
  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libcap' # R
  depends_on 'libdaemon' # R
  depends_on 'libevent' # R
  depends_on 'libssp' # R
  depends_on 'xmltoman' => :build

  configure_options "--enable-compat-libdns_sd \
      --disable-dbus \
      --disable-gtk \
      --disable-gtk3 \
      --disable-libsystemd \
      --disable-mono \
      --disable-monodoc \
      --disable-python \
      --disable-qt3 \
      --disable-qt4 \
      --disable-qt5 \
      --with-avahi-user=chronos \
      --with-avahi-group=chronos \
      --with-autoipd-group=chronos \
      --with-autoipd-user=chronos \
      --with-avahi-priv-access-group=chronos-access \
      --with-distro=none"

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/avahi/avahi-daemon.conf", "#{CREW_DEST_PREFIX}/etc/avahi/avahi-daemon.conf.default"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/avahi/hosts", "#{CREW_DEST_PREFIX}/etc/avahi/hosts.default"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/avahi/services/sftp-ssh.service", "#{CREW_DEST_PREFIX}/etc/avahi/services/sftp-ssh.service.disabled"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/avahi/services/ssh.service", "#{CREW_DEST_PREFIX}/etc/avahi/services/ssh.service.disabled"
    # start avahi-daemon from bash.d, which loads after all of env.d via #{CREW_PREFIX}/etc/profile
    File.write 'bashd_avahi', <<~BASHDAVAHI_EOF
      [[ $(pgrep -wc avahi-daemon) > 0 ]] || source #{CREW_PREFIX}/bin/startavahi
    BASHDAVAHI_EOF
    FileUtils.install 'bashd_avahi', "#{CREW_DEST_PREFIX}/etc/bash.d/avahi", mode: 0o644
    File.write 'start_avahi', <<~STARTAVAHI_EOF
      if [[ $(pgrep -wc avahi-daemon) > 0 ]]; then
        # distccd is already running.
        # Return or exit depending upon whether script was sourced.
        (return 0 2>/dev/null) && return 0 || exit 0
      fi
      hostname="$(hostname)"
      cp #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf.default #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf
      cp #{CREW_PREFIX}/etc/avahi/hosts.default #{CREW_PREFIX}/etc/avahi/hosts

      sed -i "s/#host-name=foo/host-name=$hostname/" #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf
      sed -i "s/#domain-name=local/domain-name=local/" #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf

      for netaddress in $(ip -o -f inet addr show | awk '/scope global/ {print $4}')
      do
        address="${netaddress%/*}"
        echo -e "\n${address} ${hostname}.local" >> #{CREW_PREFIX}/etc/avahi/hosts
        echo "Enabling Avahi mDNS/DNS-SD daemon for address $address ..."
      done
      mkdir -p #{CREW_PREFIX}/var/log && touch #{CREW_PREFIX}/var/log/avahi.log
      (sudo #{CREW_PREFIX}/sbin/avahi-daemon &> #{CREW_PREFIX}/var/log/avahi.log &)
    STARTAVAHI_EOF
    FileUtils.install 'start_avahi', "#{CREW_DEST_PREFIX}/bin/startavahi", mode: 0o755
    File.write 'stop_avahi', <<~STOP_AVAHI_EOF
      #!/bin/bash
      killall -9 avahi-daemon
    STOP_AVAHI_EOF
    FileUtils.install 'stop_avahi', "#{CREW_DEST_PREFIX}/bin/stopavahi", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "The avahi daemon will be automatically started, but can be stopped with 'stopavahi' and restarted with 'startavahi'."
  end
end
