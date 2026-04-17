require 'buildsystems/cmake'

class Mysql < CMake
  description "MySQL Community Edition is a freely downloadable version of the world's most popular open source database"
  homepage 'https://www.mysql.com/'
  version "9.6.0-#{CREW_ICU_VER}"
  license 'GPL-2'
  compatibility 'x86_64' # Only 64-bit platforms are supported, so this will work on aarch64 userspaces once those are supported.
  source_url 'https://github.com/mysql/mysql-server.git'
  git_hashtag "mysql-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '0dc285c0ad79fc1350fd18d1ec097b016134f8086366652a6ff6f97f85aa1795'
  })

  depends_on 'abseil_cpp' => :library
  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :executable
  depends_on 'libcyrussasl' => :build
  depends_on 'libedit' => :executable
  depends_on 'libtirpc' => :library
  depends_on 'lz4' => :library
  depends_on 'openldap' => :build
  depends_on 'openssl' => :library
  depends_on 'protobuf' => :library
  depends_on 'rapidjson' => :build
  depends_on 'rpcsvc_proto' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  print_source_bashrc

  def self.postinstall
    return if CREW_IN_CONTAINER

    FileUtils.mkdir_p "#{CREW_PREFIX}/var/mysql/data"
    system "mysqld --initialize-insecure --user=#{USER}" unless Dir.empty? "#{CREW_PREFIX}/var/mysql/data"
    ExitMessage.add <<~EOM

      WARNING: This is an insecure install without a root password!

      To lockdown permissions, execute the following:
      mysql_secure_installation

      To reset the root password, see https://dev.mysql.com/doc/refman/8.4/en/resetting-permissions.html#resetting-permissions-unix.

      To start/stop mysqld, execute the following:
      mysql.server start
      mysql.server stop

      mysql.server start will execute on login.
      To prevent this, edit or remove #{CREW_PREFIX}/etc/bash.d/01-mysql.

      Databases are stored in #{CREW_PREFIX}/var/mysql/data.

      MySQL Server documentation: https://dev.mysql.com/doc/refman/9.1/en/
    EOM
  end

  def self.postremove
    if Dir.exist?("#{CREW_PREFIX}/var/mysql")
      puts "\nWARNING: This will delete all your databases!".orange
      Package.agree_to_remove("#{CREW_PREFIX}/var/mysql")
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
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/01-mysql", <<~EOF
      if [[ ! -f /.dockerenv ]]; then
        [ -x #{CREW_PREFIX}/bin/mysql.server ] && #{CREW_PREFIX}/bin/mysql.server start
      fi
    EOF
  end
end
