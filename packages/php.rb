require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.33-7.2.1'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.33"
    puts "7.0 = PHP 7.0.27"
    puts "7.1 = PHP 7.1.13"
    puts "7.2 = PHP 7.2.1"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        source_url 'https://php.net/distributions/php-5.6.33.tar.xz'
        source_sha256 '9004995fdf55f111cd9020e8b8aff975df3d8d4191776c601a46988c375f3553'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.33-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.33-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.33-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.33-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'a1eecf07f549303f9c7f397e1a0f947b743e96c0d61da29bc8beb24b0d44b64f',
           armv7l: 'a1eecf07f549303f9c7f397e1a0f947b743e96c0d61da29bc8beb24b0d44b64f',
             i686: 'bbea0f8f7edcde6fb72e97ed8f1088c7445ff2262e2c41e92fce66b7e7b0f42c',
           x86_64: 'fcb5e4863e7a2a5fe4689027f843ffd458e2151ae9bf4a6ee9333b66bc4df96f',
        })
        break
      when '7.0'
        source_url 'https://php.net/distributions/php-7.0.27.tar.xz'
        source_sha256 '4b2bc823e806dbf7b62fe0b92b0d14b0c6e03f88c3fc5d96278416c54ce11f6c'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.27-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.27-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.27-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.27-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '1e2a89fa1eb54959ac16d37c69484321508ece99610a1abe6c636b255f0b4533',
           armv7l: '1e2a89fa1eb54959ac16d37c69484321508ece99610a1abe6c636b255f0b4533',
             i686: '6c4d95bf1745672f370004a5120d308ba7402cece83a457d6eabd3cda779dea3',
           x86_64: 'c57b5e0caba5a158ab04f938a38cf3efb418658d06eb24e7e39a7c013e75d8f7',
        })
        break
      when '7.1'
        source_url 'https://php.net/distributions/php-7.1.13.tar.xz'
        source_sha256 '1a0b3f2fb61959b57a3ee01793a77ed3f19bde5aa90c43dcacc85ea32f64fc10'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.13-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.13-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.13-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.13-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'fd4145ec20d03c332a517c3ba33c1af9f2a4f5d152be4f3ee278703ac107df77',
           armv7l: 'fd4145ec20d03c332a517c3ba33c1af9f2a4f5d152be4f3ee278703ac107df77',
             i686: '13aa68eb7b2a56fc46858eea6c7253dfdd22db120ca41e41a40c5fd6976d0a53',
           x86_64: '5009f4adc925a601f229990e1277ad1a7531b105156f5e0f51d319aae89c738c',
        })
        break
      when '7.2'
        source_url 'https://php.net/distributions/php-7.2.1.tar.xz'
        source_sha256 '6c6cf82fda6660ed963821eb0525214bb3547e8e29f447b9c15b2d8e6efd8822'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.1-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.1-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.1-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.1-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'b02e6f36df33ead70c249d97887800c18eefbe85b0063f3b0a7961ed663fccec',
           armv7l: 'b02e6f36df33ead70c249d97887800c18eefbe85b0063f3b0a7961ed663fccec',
             i686: '9ff042bf22c741a787457c1c864eec8af6f0e4b728679c1d2f6b98495565dc0a',
           x86_64: '109e84485e8ee2a210ed501cc3935c6b2803a3b96e69df47b6bfb00275e85f59',
        })
        break
      when '0'
        abort
        break
      else
        puts "Please select from one of the options or enter 0 to cancel."
      end
    end
  end

  depends_on 'pkgconfig' => :build
  depends_on 'zlibpkg'
  depends_on 'libpng'
  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'openssl'
  depends_on 'curl'
  depends_on 'pcre'
  depends_on 'readline'

  def self.build
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --with-curl \
      --with-gd \
      --with-xsl \
      --enable-mbstring \
      --with-openssl \
      --with-pcre-regex \
      --with-readline \
      --with-zlib"
    system 'make'
  end

  def self.install
    system "make", "INSTALL_ROOT=#{CREW_DEST_DIR}", "install"

    # clean up some files created under #{CREW_DEST_DIR}. check http://pear.php.net/bugs/bug.php?id=20383 for more details
    system "mv", "#{CREW_DEST_DIR}/.depdb", "#{CREW_DEST_LIB_PREFIX}/php"
    system "mv", "#{CREW_DEST_DIR}/.depdblock", "#{CREW_DEST_LIB_PREFIX}/php"
    system "rm", "-rf", "#{CREW_DEST_DIR}/.channels", "#{CREW_DEST_DIR}/.filemap", "#{CREW_DEST_DIR}/.lock", "#{CREW_DEST_DIR}/.registry"
  end
end
