require 'package'

class Smbclient < Package
  description 'Tools to access a servers filespace and printers via SMB'
  homepage 'https://www.samba.org'
  version "4.24.4-#{CREW_ICU_VER}"
  license 'GPLv3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.samba.org/pub/samba/stable/samba-#{version.split('-').first}.tar.gz"
  source_sha256 'df2c51ab4361ec626ab9988e5946efcca8465bc7afae834291d5558468265ff8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bee6b75d6b57b314331a88e0f0de356a0c7e0c8643066309e7007e279e7e58a8',
     armv7l: 'bee6b75d6b57b314331a88e0f0de356a0c7e0c8643066309e7007e279e7e58a8',
     x86_64: 'd8d10c0c83e4d8afd35420af8d17bf89be3e9d7558582a461fa813962ad5aabf'
  })

  depends_on 'acl' => :library
  depends_on 'avahi' => :library
  depends_on 'cmocka' => :build
  depends_on 'cups' => :build
  depends_on 'docbook' => :build # We still need to set @xml_catalog_files since the XML_CATALOG_FILES env variable might not get picked up before the build.
  depends_on 'gcc_lib' # R
  depends_on 'gdb' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library
  depends_on 'gpgme' => :build
  depends_on 'icu4c' => :library
  depends_on 'jansson' => :library
  depends_on 'ldb' => :build
  depends_on 'libarchive' => :executable
  depends_on 'libbsd' => :library
  depends_on 'libcap' => :library
  depends_on 'libngtcp2' => :library
  depends_on 'libtasn1' => :library
  depends_on 'libtirpc' => :build
  depends_on 'libunwind' => :build
  depends_on 'liburing' => :build
  depends_on 'libxcrypt' => :library
  depends_on 'linux_pam' => :library
  depends_on 'lmdb' => :library
  depends_on 'ncurses' => :build
  depends_on 'openldap' => :library
  depends_on 'perl_json' => :build
  depends_on 'perl_parse_yapp' => :build
  depends_on 'popt' => :library
  depends_on 'py3_dnspython' => :build
  depends_on 'py3_markdown' => :build
  depends_on 'readline' => :executable
  depends_on 'talloc' => :library
  depends_on 'tdb' => :library
  depends_on 'tevent' => :library
  depends_on 'xmlto' => :build
  depends_on 'zlib' => :library

  @samba4_idmap_modules = 'idmap_ad,idmap_rid,idmap_adex,idmap_hash,idmap_tdb2'
  @samba4_pdb_modules = 'pdb_tdbsam,pdb_ldap,pdb_ads,pdb_smbpasswd,pdb_wbc_sam,pdb_samba4'
  @samba4_auth_modules = 'auth_unix,auth_wbc,auth_server,auth_netlogond,auth_script,auth_samba4'

  @smbclient_bins = %w[smbclient rpcclient smbspool smbtree smbcacls
                       smbcquotas smbget net nmblookup smbtar]
  @smbclient_pkgconfig = %w[smbclient netapi wbclient]

  @xml_catalog_files = ENV.fetch('XML_CATALOG_FILES', "#{CREW_PREFIX}/etc/xml/catalog")

  def self.patch
    system "sed -e 's:<gpgme.h>:<gpgme/gpgme.h>:' \
    -i source4/dsdb/samdb/ldb_modules/password_hash.c"
    system "sed -i 's,/etc/xml/catalog,#{@xml_catalog_files},g' docs-xml/Makefile"
    system "sed -i 's,file:///etc/xml/catalog,#{@xml_catalog_files},g' buildtools/wafsamba/wafsamba.py"
  end

  def self.build
    system './configure --help'
    system "python_LDFLAGS='' ./configure --enable-fhs \
      #{CREW_CONFIGURE_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --sbindir=#{CREW_PREFIX}/bin \
      --libdir=#{CREW_LIB_PREFIX} \
      --libexecdir=#{CREW_LIB_PREFIX}/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --with-configdir=#{CREW_PREFIX}/etc/samba \
      --with-lockdir=#{CREW_PREFIX}/var/cache/samba \
      --builtin-libraries=NONE \
      --bundled-libraries=!tdb,!talloc,!pytalloc-util,!tevent,!popt,!ldb,!pyldb-util,libquic,NONE \
      --disable-python \
      --disable-rpath \
      --disable-rpath-install \
      --with-acl-support \
      --with-ads \
      --with-ldap \
      --with-pam \
      --with-pammodulesdir=#{CREW_LIB_PREFIX}/security \
      --with-piddir=/run \
      --with-profiling-data \
      --with-shared-modules=#{@samba4_idmap_modules},#{@samba4_pdb_modules},#{@samba4_auth_modules} \
      --with-sockets-dir=/run/samba \
      --without-ad-dc \
      --without-smb1-server \
      --with-winbind \
      --without-systemd"
    system 'make'
    # We only need some files from the build, so just install into a
    # staging directory during build.
    FileUtils.mkdir_p 'staging'
    system 'make V=1 DESTDIR=staging install', exception: false
    FileUtils.cp 'source3/script/smbtar', "staging/#{CREW_PREFIX}/bin/"
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
