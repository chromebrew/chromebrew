require 'package'

class Glibc_fallthrough < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version LIBC_VERSION
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc version.split('-').first
  max_glibc version.split('-').first
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({})

  depends_on 'gawk' => :build
  depends_on 'filecmd' # L Fixes creating symlinks on a fresh install.
  depends_on 'libidn2' => :build
  depends_on 'texinfo' => :build
  depends_on 'patchelf' # L

  conflicts_ok
  no_env_options
  no_upstream_update

  def self.postinstall
    if File.exist?("#{CREW_LIB_PREFIX}/libc.so.6")
      FileUtils.chmod 'u=wrx', "#{CREW_LIB_PREFIX}/libc.so.6"
      @crew_libcvertokens = `#{CREW_LIB_PREFIX}/libc.so.6`.lines.first.chomp.split(/\s/)
      @libc_version = @crew_libcvertokens[@crew_libcvertokens.find_index('version') + 1].sub!(/[[:punct:]]?$/, '')
      puts "Package glibc version is #{@libc_version}.".lightblue
    else
      @libc_version = LIBC_VERSION
    end
    @libraries = %w[ld libBrokenLocale libSegFault libanl libc libcrypt
                    libdl libm libmemusage libmvec libnsl libnss_compat libnss_db
                    libnss_dns libnss_files libnss_hesiod libpcprofile libpthread
                    libthread_db libresolv librlv librt libthread_db-1.0 libutil]
    @libraries -= ['libpthread'] if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.35')
    @libraries -= ['libc'] if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.35') && Kernel.system("patchelf --print-needed #{File.join(CREW_LIB_PREFIX, 'libc.so.6')} | grep -q libC.so.6")
    @libraries -= ['libm'] if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.35') && Kernel.system("patchelf --print-needed #{File.join(CREW_LIB_PREFIX, 'libm.so.6')} | grep -q libC.so.6")
    Dir.chdir CREW_LIB_PREFIX do
      puts "System glibc version is #{@libc_version}.".lightblue
      puts 'Creating symlinks to system glibc version to prevent breakage.'.lightblue
      case ARCH
      when 'aarch64', 'armv7l'
        FileUtils.ln_sf File.realpath('/lib/ld-linux-armhf.so.3'), 'ld-linux-armhf.so.3'
      when 'x86_64'
        FileUtils.ln_sf File.realpath('/lib64/ld-linux-x86-64.so.2'), 'ld-linux-x86-64.so.2'
      end
      @libraries.each do |lib|
        # Reject entries which aren't libraries ending in .so, and which aren't files.
        # Reject text files such as libc.so because they points to files like
        # libc_nonshared.a, which are not provided by ChromeOS
        Dir["{,/usr}/#{ARCH_LIB}/#{lib}.so*"].compact.select { |i| ['shared object', 'symbolic link'].any? { |j| `file #{i}`.chomp.include? j } }.each do |k|
          FileUtils.ln_sf k, File.join(CREW_LIB_PREFIX, File.basename(k))
        end
      end
    end
  end
end
