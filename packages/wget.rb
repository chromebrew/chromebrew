require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.21.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/wget.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.3_armv7l/wget-1.21.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.3_armv7l/wget-1.21.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.3_i686/wget-1.21.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.3_x86_64/wget-1.21.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '53cb665d91a7b550087e6999c2b16289d57826fdeecef72644a8751613838585',
     armv7l: '53cb665d91a7b550087e6999c2b16289d57826fdeecef72644a8751613838585',
       i686: '0cf31261dbeae25995ca154afdd67c5833aeffdc3097ff74bc62c9b8a208888b',
     x86_64: '2cc7ca9d41bb39971fef2c93b238ca6c8cfb0ffec0be54a830dea399369d8f96'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'gperf' => :build
  depends_on 'mold' => :build
  depends_on 'libpsl'
  depends_on 'libidn2'
  depends_on 'pcre2'
  depends_on 'ca_certificates'
  no_env_options

  def self.build
    puts 'libiconv installed, Will build with libiconv.'.yellow if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    @lto = ARCH == 'i686' ? '' : '-flto=auto'
    @cc = ARCH == 'i686' ? 'clang' : 'gcc'
    system './bootstrap --skip-po --no-git --gnulib-srcdir=./gnulib'
    system "CFLAGS='-O2 -pipe #{@lto} -fPIC' LDFLAGS=#{@lto} CC=#{@cc} LD=mold \
      ./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --with-ssl=openssl"
    system 'make'
  end

  def self.check
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    File.write "#{CREW_DEST_PREFIX}/etc/wgetrc", "ca_directory=#{CREW_PREFIX}/etc/ssl/certs\n", mode: 'a'
  end
end
