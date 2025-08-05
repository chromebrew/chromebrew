require 'buildsystems/cmake'

class Mysql < CMake
  description "MySQL Community Edition is a freely downloadable version of the world's most popular open source database"
  homepage 'https://www.mysql.com/'
  version "9.4.0-#{CREW_ICU_VER}"
  license 'GPL-2'
  compatibility 'x86_64' # Only 64-bit platforms are supported, so this will work on aarch64 userspaces once those are supported.
  source_url 'https://github.com/mysql/mysql-server.git'
  git_hashtag "mysql-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '466d38093023fe22a957aec83ad8ecdd335b7207bd1c8766ea9cdc3d3861bf78'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
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
    return if CREW_IN_CONTAINER

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
    puts 'MySQL Server documentation: https://dev.mysql.com/doc/refman/9.1/en/'.lightblue
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
      if [[ ! -f /.dockerenv ]]; then
        [ -x #{CREW_PREFIX}/bin/mysql.server ] && #{CREW_PREFIX}/bin/mysql.server start
      fi
    EOF
  end
end
