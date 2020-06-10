require 'package'

class Percona_server < Package
  description 'Percona Server for MySQL® is a free, fully compatible, enhanced, open source drop-in replacement for MySQL that provides superior performance, scalability and instrumentation.'
  homepage 'https://www.percona.com/software/mysql-database/percona-server'
  version '5.7.20-19'
  compatibility 'all'
  source_url 'https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.20-19/source/tarball/percona-server-5.7.20-19.tar.gz'
  source_sha256 '17f06c07165954e7eacc3ba2cac0e1d4ba65b0b568f2437298d3c17a6a0940fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/percona_server-5.7.20-19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/percona_server-5.7.20-19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/percona_server-5.7.20-19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/percona_server-5.7.20-19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e7bdb895946e539145268d29a0c93e690ad1ff91eab871605cb2b3b686247ff5',
     armv7l: 'e7bdb895946e539145268d29a0c93e690ad1ff91eab871605cb2b3b686247ff5',
       i686: '757706998388bf559a70f53567af4518c523f1236a500e228210ce023ef41a5c',
     x86_64: '47431d59582a5be3361cbfd571de3da9a557b76cea40a01f4b58347988e7aa2c',
  })

  depends_on 'cmake' => :build
  depends_on 'percona_boost'
  depends_on 'libaio'
  depends_on 'libtirpc'
  depends_on 'psmisc'

  def self.build
    system "sed -i 's,SET(RUN_ABI_CHECK 1),SET(RUN_ABI_CHECK 0),' cmake/abi_check.cmake"
    system "cmake . \
            -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
            -DINSTALL_LIBDIR=#{ARCH_LIB} \
            -DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncurses \
            -DCMAKE_BUILD_TYPE=Release \
            -DBUILD_CONFIG=mysql_release \
            -DCOMMUNITY_BUILD=ON \
            -DWITH_EMBEDDED_SERVER=OFF"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "rm -rf #{CREW_DEST_PREFIX}/mysql-test"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > startmysql"
      system "echo 'MYSQL=\$(ps ax | grep mysqld_safe | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> startmysql"
      system "echo 'if [ -z \"\$MYSQL\" ]; then' >> startmysql"
      system "echo '  mysqld_safe &' >> startmysql"
      system "echo 'fi' >> startmysql"
      system "echo 'MYSQL=\$(ps ax | grep mysqld_safe | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> startmysql"
      system "echo 'if [ ! -z \"\$MYSQL\" ]; then' >> startmysql"
      system "echo '  echo \"mysql process \$MYSQL is running\"' >> startmysql"
      system "echo 'else' >> startmysql"
      system "echo '  echo \"mysqld failed to start\"' >> startmysql"
      system "echo '  exit 1' >> startmysql"
      system "echo 'fi' >> startmysql"
      system "echo '#!/bin/bash' > stopmysql"
      system "echo 'MYSQL=\$(ps ax | grep mysqld_safe | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> stopmysql"
      system "echo 'if [ ! -z \"\$MYSQL\" ]; then' >> stopmysql"
      system "echo '  killall mysqld' >> stopmysql"
      system "echo 'fi' >> stopmysql"
      system "echo 'MYSQL=\$(ps ax | grep mysqld_safe | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> stopmysql"
      system "echo 'if [ -z \"\$MYSQL\" ]; then' >> stopmysql"
      system "echo '  echo \"mysqld process stopped\"' >> stopmysql"
      system "echo 'else' >> stopmysql"
      system "echo '  echo \"mysqld process \$MYSQL is running\"' >> stopmysql"
      system "echo '  exit 1' >> stopmysql"
      system "echo 'fi' >> stopmysql"
      system "chmod +x st*mysql"
    end
  end

  def self.postinstall
    unless Dir.exists? "#{CREW_PREFIX}/data"
      system "mysqld --initialize-insecure --user=#{USER}"
      system "mysql_ssl_rsa_setup"
    end
    puts
    puts "Databases are stored in #{CREW_PREFIX}/data.".lightblue
    puts
    puts "To reset the root password, see https://dev.mysql.com/doc/refman/5.7/en/resetting-permissions.html#resetting-permissions-unix".lightblue
    puts
    puts "To lockdown permissions, execute the following:".lightblue
    puts "mysql_secure_installation".lightblue
    puts
    puts "To start/stop mysqld, execute the following:".lightblue
    puts "startmysql - starts mysqld".lightblue
    puts "stopmysql - stops mysqld".lightblue
    puts
    puts "To start mysqld on login, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/startmysql ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/startmysql' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To completely remove MySQL and all databases, perform the following:".lightblue
    puts "crew remove percona_server".lightblue
    puts "rm -rf #{CREW_PREFIX}/data".lightblue
    puts
    puts "Percona Server documentation: https://www.percona.com/doc/percona-server/5.7/index.html".lightblue
    puts
  end
end
