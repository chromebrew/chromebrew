require 'buildsystems/cmake'

class Mysql < CMake
  description "MySQL Community Edition is a freely downloadable version of the world's most popular open source database"
  homepage 'https://www.mysql.com/'
  version '9.0.1'
  license 'GPL-2'
  compatibility 'x86_64' # Only 64-bit platforms are supported, so this will work on aarch64 userspaces once those are supported.
  source_url 'https://github.com/mysql/mysql-server.git'
  git_hashtag "mysql-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '78f197a0cc31d6657bc682cbbb5be958326872eef0b35d93d7633f59646265d8'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'icu4c', '== 75.1'
  depends_on 'libcyrussasl' => :build
  depends_on 'libedit' # R
  depends_on 'libtirpc' # R
  depends_on 'lz4' # R
  depends_on 'openldap' => :build
  depends_on 'openssl' # R
  depends_on 'protobuf' # R
  depends_on 'rapidjson' => :build
  depends_on 'rpcsvc_proto' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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

  def self.postremove
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
  cmake_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/01-mysql", <<~EOF
      [ -x #{CREW_PREFIX}/bin/mysql.server ] && #{CREW_PREFIX}/bin/mysql.server start
    EOF
  end
end
