# Adapted from Arch Linux samba PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/samba/trunk/PKGBUILD

require 'package'

class Smbclient < Package
  description 'Tools to access a servers filespace and printers via SMB'
  homepage 'https://www.samba.org'
  version '4.14.2'
  license 'GPLv3'
  compatibility 'all'
  source_url "https://us1.samba.org/samba/ftp/stable/samba-#{version}.tar.gz"
  source_sha256 '95651da478743f7cb407aec81287536c096e3e18bb4981dbe47ca70bf6181f96'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/smbclient-4.14.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/smbclient-4.14.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/smbclient-4.14.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/smbclient-4.14.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '19d88b0a7b60b5f1002ef071f3aa8c1ecefb00067e89eff653d2c234da2ff428',
     armv7l: '19d88b0a7b60b5f1002ef071f3aa8c1ecefb00067e89eff653d2c234da2ff428',
       i686: 'd4952770d1531c5bfc34b1e3527cad7b8b13e2c04d9c2630c9d8bd630d6dbd7a',
     x86_64: 'f1c215ece0eae7eb36212ccaef962347b31b660403fa8b835a12b797e0786c2b'
  })

  depends_on 'avahi'
  depends_on 'cmocka'
  depends_on 'cmocka' => ':build'
  depends_on 'cups'
  depends_on 'cups' => ':build'
  depends_on 'docbook_xsl'
  depends_on 'docbook_xsl' => ':build'
  depends_on 'gpgme' => ':build'
  depends_on 'jansson'
  depends_on 'jansson' => ':build'
  depends_on 'ldb'
  depends_on 'ldb' => ':build'
  depends_on 'libarchive'
  depends_on 'libbsd'
  depends_on 'libbsd' => ':build'
  depends_on 'libcap'
  depends_on 'libcap' => ':build'
  depends_on 'libdb'
  depends_on 'libdb' => ':build'
  depends_on 'libunwind'
  depends_on 'liburing' => ':build'
  depends_on 'linux_pam'
  depends_on 'lmdb' => ':build'
  depends_on 'perl_parse_yapp' => ':build'
  depends_on 'popt'
  depends_on 'popt' => ':build'
  depends_on 'talloc'
  depends_on 'tdb'
  depends_on 'tevent'

  @samba4_idmap_modules = 'idmap_ad,idmap_rid,idmap_adex,idmap_hash,idmap_tdb2'
  @samba4_pdb_modules = 'pdb_tdbsam,pdb_ldap,pdb_ads,pdb_smbpasswd,pdb_wbc_sam,pdb_samba4'
  @samba4_auth_modules = 'auth_unix,auth_wbc,auth_server,auth_netlogond,auth_script,auth_samba4'

  @smbclient_bins = %w[smbclient rpcclient smbspool smbtree smbcacls
                       smbcquotas smbget net nmblookup smbtar]
  @smbclient_pkgconfig = %w[smbclient netapi wbclient]

  @python_deps = %w[Markdown dnspython]

  @xml_catalog_files = ENV['XML_CATALOG_FILES']

  def self.patch
    system "sed -e 's:<gpgme\.h>:<gpgme/gpgme.h>:' \
    -i source4/dsdb/samdb/ldb_modules/password_hash.c"
    system "sed -i 's,/etc/xml/catalog,#{@xml_catalog_files},g' docs-xml/Makefile"
    system "sed -i 's,file:///etc/xml/catalog,#{@xml_catalog_files},g' buildtools/wafsamba/wafsamba.py"
  end

  def self.prebuild
    @python_deps.each do |item|
      system "pip install --upgrade #{item}"
    end
  end

  def self.build
    system './configure --help'
    system "env CFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto=auto' \
      ./configure --enable-fhs \
      #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --sbindir=#{CREW_PREFIX}/bin \
      --libdir=#{CREW_LIB_PREFIX} \
      --libexecdir=#{CREW_LIB_PREFIX}/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --with-configdir=#{CREW_PREFIX}/etc/samba \
      --with-lockdir=#{CREW_PREFIX}/var/cache/samba \
      --builtin-libraries=NONE \
      --bundled-libraries=!tdb,!talloc,!pytalloc-util,!tevent,!popt,!ldb,!pyldb-util,NONE \
      --disable-rpath \
      --disable-rpath-install \
      --with-acl-support \
      --with-ads \
      --with-ldap \
      --with-pam \
      --with-pammodulesdir=#{CREW_LIB_PREFIX}/security \
      --with-piddir=/run \
      --with-profiling-data \
      --with-shared-modules=#{@samba4_idmap_modules},#{@samba4_pdb_modules},#{@samba4_auth_modules},vfs_io_uring \
      --with-sockets-dir=/run/samba \
      --without-ad-dc \
      --with-winbind \
      --without-systemd"
    system 'make'
    # We only need some files from the build, so just install into a
    # staging directory during build.
    FileUtils.mkdir_p 'staging'
    system 'make V=1 DESTDIR=staging install'
    FileUtils.cp 'source3/script/smbtar', "staging/#{CREW_PREFIX}/bin/"
    @python_deps.each do |item|
      system "pip uninstall --yes #{item}"
    end
  end

  def self.install
    @dest_dirs = ["#{CREW_DEST_PREFIX}/bin", "#{CREW_DEST_LIB_PREFIX}/samba",
                  "#{CREW_DEST_LIB_PREFIX}/pkgconfig", "#{CREW_DEST_MAN_PREFIX}/man1",
                  "#{CREW_DEST_MAN_PREFIX}/man7", "#{CREW_DEST_MAN_PREFIX}/man8",
                  "#{CREW_DEST_PREFIX}/include/samba-4.0", "#{CREW_DEST_LIB_PREFIX}/cups/backend",
                  "#{CREW_DEST_PREFIX}/etc/samba"]
    @dest_dirs.each do |dir|
      FileUtils.mkdir_p dir
    end
    @smbclient_bins.each do |item|
      FileUtils.install "staging#{CREW_PREFIX}/bin/#{item}", "#{CREW_DEST_PREFIX}/bin/#{item}",
                        mode: 0o755
    end
    FileUtils.mv Dir.glob("staging#{CREW_LIB_PREFIX}/lib*.so*"), "#{CREW_DEST_LIB_PREFIX}/"
    FileUtils.mv Dir.glob("staging#{CREW_LIB_PREFIX}/samba/lib*.so*"), "#{CREW_DEST_LIB_PREFIX}/samba/"
    @smbclient_pkgconfig.each do |item|
      FileUtils.mv Dir.glob("staging#{CREW_LIB_PREFIX}/pkgconfig/#{item}.pc"), "#{CREW_DEST_LIB_PREFIX}/pkgconfig/"
    end
    @smbclient_bins.each do |item|
      if File.exist?("staging#{CREW_MAN_PREFIX}/man1/#{item}.1")
        FileUtils.mv "staging#{CREW_MAN_PREFIX}/man1/#{item}.1",
                     "#{CREW_DEST_MAN_PREFIX}/man1/#{item}.1"
      end
      if File.exist?("staging#{CREW_MAN_PREFIX}/man8/#{item}.8")
        FileUtils.mv "staging#{CREW_MAN_PREFIX}/man8/#{item}.8",
                     "#{CREW_DEST_MAN_PREFIX}/man8/#{item}.8"
      end
    end
    FileUtils.mv "staging#{CREW_MAN_PREFIX}/man7/libsmbclient.7",
                 "#{CREW_DEST_MAN_PREFIX}/man7/libsmbclient.7"
    FileUtils.mv "staging#{CREW_PREFIX}/include/samba-4.0/libsmbclient.h",
                 "#{CREW_DEST_PREFIX}/include/samba-4.0/"
    FileUtils.mv "staging#{CREW_PREFIX}/include/samba-4.0/netapi.h",
                 "#{CREW_DEST_PREFIX}/include/samba-4.0/"
    FileUtils.mv "staging#{CREW_PREFIX}/include/samba-4.0/wbclient.h",
                 "#{CREW_DEST_PREFIX}/include/samba-4.0/"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/smbspool", "#{CREW_DEST_LIB_PREFIX}/cups/backend/smb"
    FileUtils.touch "#{CREW_DEST_PREFIX}/etc/samba/smb.conf"
  end
end
