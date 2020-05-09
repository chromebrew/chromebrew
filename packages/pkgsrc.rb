require 'package'

class Pkgsrc < Package
  description 'pkgsrc is a framework for building third-party software on NetBSD and other UNIX-like systems'
  homepage 'https://github.com/NetBSD/pkgsrc'
  version '2020Q1'
  source_url 'https://github.com/NetBSD/pkgsrc/archive/6ba7d2a6ee1388ad515177f5964681f2f6c13f13.tar.gz'
  source_sha256 'fe2cf98d294cdd298c9191c33c5223860f73e9bed8b9d137f0c32a579ea49803'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgsrc-2020Q1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pkgsrc-2020Q1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pkgsrc-2020Q1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgsrc-2020Q1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3e5874fdcfe1f9bbc4379c408ea2c306938b8b81aab05a733b0431cd4560c777',
     armv7l: '3e5874fdcfe1f9bbc4379c408ea2c306938b8b81aab05a733b0431cd4560c777',
       i686: 'cc7393a04bcb20413e773d265c8855554bb38d4e16bb3b802029a21d9f8a2708',
     x86_64: 'b461407fd6f86a40d4c5edae331096e57c2d9cdd0fff2e2de6f2d6ab06f53b6a',
  })

  def self.build
    system "cat << 'EOF' > pkglocate
#!/bin/bash
cd #{CREW_PREFIX}/pkgsrc
./pkglocate \"\$@\"
EOF"
  end

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      abi = ''
    when 'i686'
      abi = '32'
    when 'x86_64'
      abi = '64'
    end
    ENV['SH'] = '/bin/bash'
    ENV['OS_VARIANT'] = 'chromeos'
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    FileUtils.chdir 'bootstrap' do
      system "./bootstrap --abi=#{abi} --preserve-path --unprivileged --prefix=#{CREW_PREFIX}/pkg \
--pkgdbdir=#{CREW_PREFIX}/pkg/pkgdb --sysconfdir=#{CREW_PREFIX}/pkg/etc --varbase=#{CREW_PREFIX}/pkg/var \
--workdir=#{CREW_DEST_PREFIX} --cwrappers=no --prefer-pkgsrc=yes --make-jobs=#{CREW_NPROC}"
    end
    FileUtils.mv "#{CREW_PREFIX}/pkg", "#{CREW_DEST_PREFIX}"
    FileUtils.chdir "#{CREW_DEST_PREFIX}/bin" do
      system 'rm -f bmake nawk sed'
    end
    FileUtils.chdir "#{CREW_DEST_PREFIX}/sbin" do
      system 'rm -f *'
    end
    FileUtils.chdir "#{CREW_DEST_PREFIX}" do
      system "wget ftp://ftp.netbsd.org/pub/pkgsrc/pkgsrc-#{version}/pkgsrc-#{version}.tar.xz"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("pkgsrc-#{version}.tar.xz") ) == '133d2f79115c87ad7dbf6f7ab604ddc0d09afe3b1d3c4cda5670c1fb758eb283'
      system "tar xvf pkgsrc-#{version}.tar.xz"
      FileUtils.rm_f "pkgsrc-#{version}.tar.xz"
      FileUtils.rm_rf 'wrk'
    end
    system "install -Dm755 pkglocate #{CREW_DEST_PREFIX}/pkg/sbin/pkglocate"
  end

  def self.postinstall
    puts
    puts "You may wish to have the vulnerabilities file downloaded daily so that it"
    puts "remains current. This may be done by adding an appropriate entry to the root"
    puts "users crontab(5) entry. For example, the entry"
    puts
    puts "# Download vulnerabilities file"
    puts "0 3 * * * #{CREW_PREFIX}/pkg/sbin/pkg_admin fetch-pkg-vulnerabilities >/dev/null 2>&1"
    puts "# Audit the installed packages and email results to root"
    puts "9 3 * * * #{CREW_PREFIX}/pkg/sbin/pkg_admin audit |mail -s 'Installed package audit result' \\"
    puts "            root >/dev/null 2>&1"
    puts
    puts "will update the vulnerability list every day at 3AM, followed by an audit at"
    puts "3:09AM. The result of the audit are then emailed to root. On NetBSD this may be"
    puts "accomplished instead by adding the following line to #{CREW_PREFIX}/pkg/etc/daily.conf:"
    puts
    puts "fetch_pkg_vulnerabilities=YES"
    puts
    puts "to fetch the vulnerability list from the daily security script. The system is"
    puts "set to audit the packages by default but can be set explicitly, if desired (not"
    puts "required), by adding the following line to #{CREW_PREFIX}/pkg/etc/security.conf:"
    puts
    puts "check_pkg_vulnerabilities=YES"
    puts
    puts "Both pkg_admin subcommands can be run as as an unprivileged user,"
    puts "as long as the user chosen has permission to read the pkgdb and to write"
    puts "the pkg-vulnerabilities to #{CREW_PREFIX}/pkg/pkgdb."
    puts
    puts "The behavior of pkg_admin and pkg_add can be customised with"
    puts "pkg_install.conf.  Please see pkg_install.conf(5) for details."
    puts
    puts "If you want to use GPG signature verification you will need to install"
    puts "GnuPG and set the path for GPG appropriately in your pkg_install.conf."
    puts "==========================================================================="
    puts "===> running: #{CREW_PREFIX}/bin/install-sh -d -o chronos -g lp #{CREW_PREFIX}/pkg/etc"
    puts
    puts "==========================================================================="
    puts
    puts "An example mk.conf file with the settings you provided to 'bootstrap'"
    puts "has been created for you. It can be found in:"
    puts
    puts "      #{CREW_PREFIX}/pkg/etc/mk.conf"
    puts
    puts "You can find extensive documentation of the NetBSD Packages Collection"
    puts "in #{CREW_PREFIX}/doc/pkgsrc.txt."
    puts
    puts "Thank you for using pkgsrc!".lightgreen
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\"#{CREW_PREFIX}/pkg/bin:#{CREW_PREFIX}/pkg/gnu/bin:#{CREW_PREFIX}/pkg/sbin:\$PATH\"' >> ~/.bashrc".lightblue
    puts "echo 'export MANPATH=\"#{CREW_PREFIX}/pkg/man:\$MANPATH\"' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To install packages, execute the following:".lightblue
    puts "cd #{CREW_PREFIX}/pkgsrc/<category>/<package>".lightblue
    puts "bmake package-install".lightblue
    puts "Example:".lightblue
    puts "cd #{CREW_PREFIX}/pkgsrc/net/libfetch && bmake package-install".lightblue
    puts
    puts "To search packages, execute 'pkglocate <string>'.".lightblue
    puts
    puts "To completely remove pkgsrc and all packages, execute the following:".lightblue
    puts "crew remove pkgsrc".lightblue
    puts "rm -rf #{CREW_PREFIX}/pkg #{CREW_PREFIX}/pkgsrc".lightblue
    puts
  end
end
