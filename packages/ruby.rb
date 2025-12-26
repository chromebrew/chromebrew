require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '4.0.0'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  # git_hashtag '07f7832cffea879946a796e066ccb13ccb4b2abd'
  # git_hashtag "v#{version.split('-').first.gsub('.', '_')}"
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6612e80e2300c7d98a08440cec8c0f124589613088792c60a116b58b719c6757',
     armv7l: '6612e80e2300c7d98a08440cec8c0f124589613088792c60a116b58b719c6757',
       i686: 'c47ff58b25e5df0e92ed4d31ac5fde52fc91b0ab007ddc1672032e1a2d38339d',
     x86_64: '3fe70c2bb972b3dbb3fe66efa6d8ece373a3ea0d266cdf81c00a18e345ad267e'
  })

  depends_on 'ca_certificates' # L
  depends_on 'filecmd' # L (This is to enable file command use in package files.)
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libffi' # R
  depends_on 'libxcrypt' # R
  depends_on 'libyaml' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R

  conflicts_ok # Needed for successful build.

  # at run-time, system's gmp, openssl, and zlib can be used

  def self.patch
    # Download bundled gems version from Top of Tree. Otherwise outdated
    # compile needed gems during install can cause issues when updates
    # are attempted.
    downloader 'https://github.com/ruby/ruby/raw/refs/heads/master/gems/bundled_gems', 'SKIP', 'gems/bundled_gems'
  end

  def self.build
    system '[ -x configure ] || autoreconf -fiv'
    system 'filefix'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto=auto -fuse-ld=mold' \
      LD=mold \
      ./configure #{CREW_CONFIGURE_OPTIONS} \
      --enable-shared \
      #{'--enable-yjit' if ARCH == 'x86_64' || ARCH == 'aarch64'} \
      --disable-fortify-source"
    system "MAKEFLAGS='--jobs #{CREW_NPROC}' make"
  end

  def self.check
    # Do not run checks if rebuilding current ruby version.
    # RUBY_VERSION is a built-in ruby constant.
    system "MAKEFLAGS='--jobs #{CREW_NPROC}' make check || true" unless version.split('-')[0] == RUBY_VERSION
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # See https://stackoverflow.com/questions/1844118/ruby-split-string-at-character-counting-from-the-right-side.
    @ruby_ver = version.split(/\.([^.]*)$/).first
    # Gems are stored in a ruby majorversion.minorversion.0 folder.
    @gemrc = <<~GEMRCEOF
      gem: --no-document
      gempath: #{CREW_LIB_PREFIX}/ruby/gems/#{@ruby_ver}.0
    GEMRCEOF
    FileUtils.mkdir_p CREW_DEST_HOME
    File.write("#{CREW_DEST_HOME}/.gemrc", @gemrc)
  end

  def self.postinstall
    puts 'Updating ruby gems. This may take a while...'
    # update_rubygems is provided by the ruby_rubygems_update package.
    system 'gem install rubygems-update', exception: false unless File.executable?("#{CREW_PREFIX}/bin/update_rubygems")
    system 'update_rubygems', exception: false
    # install for Ruby 3.4
    system 'gem uninstall resolv-replace', exception: false
    system 'gem install highline ptools', exception: false
    system "gem update #{'--silent' unless @opt_verbose} -N --system", exception: false
  end
end
