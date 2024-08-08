require 'buildsystems/cmake'

class Mysql < CMake
  description "MySQL Community Edition is a freely downloadable version of the world's most popular open source database"
  homepage 'https://www.mysql.com/'
  version '8.4.0'
  license 'GPL-2'
  compatibility 'x86_64' # Only 64-bit platforms are supported, so this will work on aarch64 userspaces once those are supported.
  source_url 'https://cdn.mysql.com/Downloads/MySQL-8.4/mysql-8.4.0.tar.gz'
  source_sha256 '47a5433fcdd639db836b99e1b5459c2b813cbdad23ff2b5dd4ad27f792ba918e'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'a8c56afb3c98bcb366e272beba199943279c4307d57e36f19e05e2fe810d650a'
  })

  depends_on 'boost'
  depends_on 'icu4c'
  depends_on 'libcyrussasl'
  depends_on 'libedit'
  depends_on 'lz4'
  depends_on 'openldap'
  depends_on 'openssl'
  depends_on 'protobuf'
  depends_on 'rapidjson'
  depends_on 'rpcsvc_proto'
  depends_on 'zlib'
  depends_on 'zstd'
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'libtirpc' # R

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/01-mysql", <<~EOF
      [ -x #{CREW_PREFIX}/bin/mysql.server ] && #{CREW_PREFIX}/bin/mysql.server start
    EOF
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/var/mysql/data"
    system "mysqld --initialize-insecure --user=#{USER}" unless Dir.empty? "#{CREW_PREFIX}/var/mysql/data"
    puts
    puts 'WARNING: This is an insecure install without a root password!'.orange
    puts
    puts 'To lockdown permissions, execute the following:'.orange
    puts 'mysql_secure_installation'.orange
    puts
    puts 'To reset the root password, see https://dev.mysql.com/doc/refman/8.4/en/resetting-permissions.html#resetting-permissions-unix.'.lightblue
    puts
    puts 'To start/stop mysqld, execute the following:'.lightblue
    puts 'mysql.server start'.lightblue
    puts 'mysql.server stop'.lightblue
    puts
    puts 'mysql.server start will execute on login.'.lightblue
    puts "To prevent this, edit or remove #{CREW_PREFIX}/etc/bash.d/01-mysql.".lightblue
    puts
    puts "Databases are stored in #{CREW_PREFIX}/var/mysql/data.".lightblue
    puts
    puts 'MySQL Server documentation: https://dev.mysql.com/doc/refman/8.4/en/'.lightblue
    puts
  end

  def self.remove
    if Dir.exist?("#{CREW_PREFIX}/var/mysql")
      puts "\nWARNING: This will delete all your databases!".orange
      print "Would you like to remove #{CREW_PREFIX}/var/mysql? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf("#{CREW_PREFIX}/var/mysql")
        puts "#{CREW_PREFIX}/var/mysql removed.".lightgreen
      else
        puts "#{CREW_PREFIX}/var/mysql saved.".lightgreen
      end
    end
  end

  cmake_options "-DWITH_SYSTEM_LIBS=ON \
        -DWITH_ROUTER=OFF \
        -DINSTALL_DOCDIR=share/doc/mysql \
        -DINSTALL_MANDIR=share/man \
        -DINSTALL_INFODIR=share/info \
        -DINSTALL_LIBDIR=#{ARCH_LIB} \
        -DINSTALL_MYSQLSHAREDIR=share/mysql \
        -DINSTALL_DOCREADMEDIR=share/mysql \
        -DINSTALL_INCLUDEDIR=include/mysql \
        -DINSTALL_PLUGINDIR=lib/mysql/plugin \
        -DINSTALL_SUPPORTFILESDIR=bin \
        -DINSTALL_MYSQLTESTDIR= \
        -DMYSQL_DATADIR=#{CREW_PREFIX}/var/mysql/data \
        -DWITH_UNIT_TESTS=OFF" # Since we don't currently run the tests, there's no point in building them.
  # 52/136 Test  #52: merge_small_tests ..................................***Failed   62.42 sec
  # run_tests
end
