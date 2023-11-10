require 'package'

class Pkgsrc < Package
  description 'pkgsrc is a framework for building third-party software on NetBSD and other UNIX-like systems'
  homepage 'https://github.com/NetBSD/pkgsrc'
  version '2021Q1'
  license '' # Can't find license
  compatibility 'all'
  source_url 'https://github.com/NetBSD/pkgsrc/archive/ccaf3cb68a965f1b055b3e04485d725fc7043813.tar.gz'
  source_sha256 '16039f24bb84d5046832e462cfd7a21c5f53dd15792a9e6b71fa4faec3a7ab4e'

  def self.build
    @pkglocate = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/pkgsrc
      ./pkglocate "$@"
    EOF
    File.write('pkglocate', @pkglocate)
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
    FileUtils.chdir 'bootstrap' do
      system "./bootstrap --abi=#{abi} --preserve-path --unprivileged --prefix=#{CREW_PREFIX}/pkg \
--pkgdbdir=#{CREW_PREFIX}/pkg/pkgdb --sysconfdir=#{CREW_PREFIX}/pkg/etc --varbase=#{CREW_PREFIX}/pkg/var \
--workdir=#{CREW_DEST_PREFIX} --cwrappers=no --prefer-pkgsrc=yes --make-jobs=#{CREW_NPROC}"
    end
    FileUtils.mv "#{CREW_PREFIX}/pkg", CREW_DEST_PREFIX
    FileUtils.chdir "#{CREW_DEST_PREFIX}/bin" do
      system 'rm -f bmake nawk sed'
    end
    FileUtils.chdir "#{CREW_DEST_PREFIX}/sbin" do
      system 'rm -f *'
    end
    FileUtils.chdir CREW_DEST_PREFIX do
      system "curl -#LO ftp://ftp.netbsd.org/pub/pkgsrc/pkgsrc-#{version}/pkgsrc-#{version}.tar.xz"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read("pkgsrc-#{version}.tar.xz")) == '133d2f79115c87ad7dbf6f7ab604ddc0d09afe3b1d3c4cda5670c1fb758eb283'
      system "tar xvf pkgsrc-#{version}.tar.xz"
      FileUtils.rm_f "pkgsrc-#{version}.tar.xz"
      FileUtils.rm_rf 'wrk'
    end
    system "install -Dm755 pkglocate #{CREW_DEST_PREFIX}/pkg/sbin/pkglocate"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # NetBSD pkgsrc configuration
      source #{CREW_PREFIX}/share/s/s-completion.bash
      export PATH="$PATH:#{CREW_PREFIX}/pkg/bin:#{CREW_PREFIX}/pkg/gnu/bin:#{CREW_PREFIX}/pkg/sbin"
      export MANPATH="$MANPATH:#{CREW_PREFIX}/pkg/man"
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/pkgsrc", @env)
  end

  def self.postinstall
    # This needs more help than saltedcoffii can do right now
    puts
    puts 'You may wish to have the vulnerabilities file downloaded daily so that it'
    puts 'remains current. This may be done by adding an appropriate entry to the root'
    puts 'users crontab(5) entry. For example, the entry'
    puts
    puts '# Download vulnerabilities file'
    puts "0 3 * * * #{CREW_PREFIX}/pkg/sbin/pkg_admin fetch-pkg-vulnerabilities >/dev/null 2>&1"
    puts '# Audit the installed packages and email results to root'
    puts "9 3 * * * #{CREW_PREFIX}/pkg/sbin/pkg_admin audit |mail -s 'Installed package audit result' \\"
    puts '            root >/dev/null 2>&1'
    puts
    puts 'will update the vulnerability list every day at 3AM, followed by an audit at'
    puts '3:09AM. The result of the audit are then emailed to root. On NetBSD this may be'
    puts "accomplished instead by adding the following line to #{CREW_PREFIX}/pkg/etc/daily.conf:"
    puts
    puts 'fetch_pkg_vulnerabilities=YES'
    puts
    puts 'to fetch the vulnerability list from the daily security script. The system is'
    puts 'set to audit the packages by default but can be set explicitly, if desired (not'
    puts "required), by adding the following line to #{CREW_PREFIX}/pkg/etc/security.conf:"
    puts
    puts 'check_pkg_vulnerabilities=YES'
    puts
    puts 'Both pkg_admin subcommands can be run as as an unprivileged user,'
    puts 'as long as the user chosen has permission to read the pkgdb and to write'
    puts "the pkg-vulnerabilities to #{CREW_PREFIX}/pkg/pkgdb."
    puts
    puts 'The behavior of pkg_admin and pkg_add can be customised with'
    puts 'pkg_install.conf.  Please see pkg_install.conf(5) for details.'
    puts
    puts 'If you want to use GPG signature verification you will need to install'
    puts 'GnuPG and set the path for GPG appropriately in your pkg_install.conf.'
    puts '==========================================================================='
    puts "===> running: #{CREW_PREFIX}/bin/install-sh -d -o chronos -g lp #{CREW_PREFIX}/pkg/etc"
    puts
    puts '==========================================================================='
    puts
    puts "An example mk.conf file with the settings you provided to 'bootstrap'"
    puts 'has been created for you. It can be found in:'
    puts
    puts "      #{CREW_PREFIX}/pkg/etc/mk.conf"
    puts
    puts 'You can find extensive documentation of the NetBSD Packages Collection'
    puts "in #{CREW_PREFIX}/doc/pkgsrc.txt."
    puts
    puts 'Thank you for using pkgsrc!'.lightgreen
    puts
    puts 'To install packages, execute the following:'.lightblue
    puts "cd #{CREW_PREFIX}/pkgsrc/<category>/<package>".lightblue
    puts 'bmake package-install'.lightblue
    puts 'Example:'.lightblue
    puts "cd #{CREW_PREFIX}/pkgsrc/net/libfetch && bmake package-install".lightblue
    puts
    puts "To search packages, execute 'pkglocate <string>'.".lightblue
    puts
  end

  def self.remove
    puts
    puts 'To completely remove pkgsrc and all packages, execute the following:'.lightblue
    puts "rm -rf #{CREW_PREFIX}/pkg #{CREW_PREFIX}/pkgsrc".lightblue
    puts
  end
end
