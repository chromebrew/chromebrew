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
       i686: 'db16f2492265fdf0c0b49f7fedaa5db3e359160ffbf5f5d3563b267d6d3bb519',
    aarch64: '683106ea3481621c8e208fafe46e2a28691373026f64d29391a954269ef7da9a',
     armv7l: '683106ea3481621c8e208fafe46e2a28691373026f64d29391a954269ef7da9a',
     x86_64: '9c6af0c0880b971057aac17d8f7d460b07ba09a3e8b41d4a279154c4abc16658'
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
    File.write 'bashd_avahi', <<~BASHDAVAHI_EOF
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
      (#{CREW_PREFIX}/sbin/avahi-daemon &> #{CREW_PREFIX}/var/log/avahi.log &)
    BASHDAVAHI_EOF
    FileUtils.install 'bashd_avahi', "#{CREW_DEST_PREFIX}/etc/bash.d/avahi", mode: 0o644
  end
end
