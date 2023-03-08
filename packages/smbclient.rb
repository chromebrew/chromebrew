require 'package'

class Smbclient < Package
  description 'Tools to access a servers filespace and printers via SMB'
  homepage 'https://www.samba.org'
  version '4.18.0'
  license 'GPLv3'
  compatibility 'all'
  source_url 'https://download.samba.org/pub/samba/stable/samba-4.18.0.tar.gz'
  source_sha256 '70348656ef807be9c8be4465ca157cef4d99818e234253d2c684cc18b8408149'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/smbclient/4.18.0_armv7l/smbclient-4.18.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/smbclient/4.18.0_armv7l/smbclient-4.18.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/smbclient/4.18.0_i686/smbclient-4.18.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/smbclient/4.18.0_x86_64/smbclient-4.18.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a38a5fad0e20363676d14560f9e05e3b1e746d23feed9e46fe95c7e02c62eb03',
     armv7l: 'a38a5fad0e20363676d14560f9e05e3b1e746d23feed9e46fe95c7e02c62eb03',
       i686: '816f819404ff0ef963606976e254b4a9ceaf672ddcd3ee47a6f2c0a02447b55b',
     x86_64: '42b704298039f3b23734048f40ebfb0bd2067737de0befdbbff5b5d65b63837d'
  })

  depends_on 'acl' # R
  depends_on 'avahi' # R
  depends_on 'cmocka' => :build
  depends_on 'cups' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'gpgme' => :build
  depends_on 'icu4c' # R
  depends_on 'jansson' # R
  depends_on 'ldb' # R
  depends_on 'libarchive' # R
  depends_on 'libbsd' # R
  depends_on 'libcap' # R
  depends_on 'libtasn1' # R
  depends_on 'libunwind' # R
  depends_on 'liburing' => :build
  depends_on 'linux_pam' # R
  depends_on 'lmdb' => :build
  depends_on 'openldap' # R
  depends_on 'perl_json' => :build
  depends_on 'perl_parse_yapp' => :build
  depends_on 'popt' # R
  depends_on 'py3_dnspython' => :build
  depends_on 'py3_markdown' => :build
  depends_on 'readline' # R
  depends_on 'talloc' # R
  depends_on 'tdb' # R
  depends_on 'tevent' # R
  depends_on 'zlibpkg' # R

  @samba4_idmap_modules = 'idmap_ad,idmap_rid,idmap_adex,idmap_hash,idmap_tdb2'
  @samba4_pdb_modules = 'pdb_tdbsam,pdb_ldap,pdb_ads,pdb_smbpasswd,pdb_wbc_sam,pdb_samba4'
  @samba4_auth_modules = 'auth_unix,auth_wbc,auth_server,auth_netlogond,auth_script,auth_samba4'

  @smbclient_bins = %w[smbclient rpcclient smbspool smbtree smbcacls
                       smbcquotas smbget net nmblookup smbtar]
  @smbclient_pkgconfig = %w[smbclient netapi wbclient]

  @xml_catalog_files = ENV.fetch('XML_CATALOG_FILES', nil)

  def self.patch
    system "sed -e 's:<gpgme.h>:<gpgme/gpgme.h>:' \
    -i source4/dsdb/samdb/ldb_modules/password_hash.c"
    system "sed -i 's,/etc/xml/catalog,#{@xml_catalog_files},g' docs-xml/Makefile"
    system "sed -i 's,file:///etc/xml/catalog,#{@xml_catalog_files},g' buildtools/wafsamba/wafsamba.py"
  end

  def self.build
    system './configure --help'
    system "python_LDFLAGS='' ./configure --enable-fhs \
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
