require 'package'

class Mysql < Package
  description "MySQL Community Edition is a freely downloadable version of the world's most popular open source database"
  homepage 'https://www.mysql.com/'
  version '8.0.27'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.27-linux-glibc2.17-x86_64-minimal.tar.xz'
  source_sha256 '45c683b233af3569ecad90ea7161b8e56bc5d85ef50a74d27811db99ed4d6fa9'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'numactl'

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/mysql"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'man/', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/mysql"
    Dir["#{CREW_DEST_PREFIX}/mysql/bin/*"].map do |f|
      f.sub!("#{CREW_DEST_DIR}", '')
      FileUtils.ln_s f, "#{CREW_DEST_PREFIX}/bin/"
    end
    FileUtils.ln_s "#{CREW_PREFIX}/mysql/support-files/mysql.server", "#{CREW_DEST_PREFIX}/bin/mysql.server"
    FileUtils.ln_s "#{CREW_PREFIX}/mysql/support-files/mysql_multi.server", "#{CREW_DEST_PREFIX}/bin/mysql_multi.server"
  end

  def self.postinstall
    unless Dir.exists? "#{CREW_PREFIX}/mysql/data"
      system "mysqld --initialize-insecure --user=#{USER}"
    end
    puts
    puts "WARNING: This is an insecure install without a root password!".orange
    puts
    puts "To lockdown permissions, execute the following:".orange
    puts "mysql_secure_installation".orange
    puts
    puts "To reset the root password, see https://dev.mysql.com/doc/refman/8.0/en/resetting-permissions.html#resetting-permissions-unix".lightblue
    puts
    puts "To start/stop mysqld, execute the following:".lightblue
    puts "mysql.server start - to start mysqld".lightblue
    puts "mysql.server stop - to stop mysqld".lightblue
    puts
    puts "To start mysqld on login, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/mysql.server ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/mysql.server start' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "Databases are stored in #{CREW_PREFIX}/mysql/data.".lightblue
    puts
    puts "MySQL Server documentation: https://dev.mysql.com/doc/refman/8.0/en/".lightblue
    puts
  end

  def self.remove
    data_dir = "#{CREW_PREFIX}/mysql"
    if Dir.exist? "#{data_dir}"
      puts "\nWARNING: This will delete all your databases!".orange
      print "Would you like to remove #{data_dir}? [y/N] "
      case $stdin.getc
      when 'y', 'Y'
        FileUtils.rm_rf "#{data_dir}"
        puts "#{data_dir} removed.".lightred
      else
        puts "#{data_dir} saved.".lightgreen
      end
    end
  end
end
