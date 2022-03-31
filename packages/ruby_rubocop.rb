# Adapted from Arch Linux ruby-rubocop PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ruby-rubocop

require 'package'

class Ruby_rubocop < Package
  description 'A Ruby static code analyzer and formatter'
  homepage 'https://rubocop.org'
  version '1.26.1'
  compatibility 'all'
  source_url 'https://github.com/rubocop/rubocop.git'
  git_hashtag "v#{version}"


  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.26.1_armv7l/ruby_rubocop-1.26.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.26.1_armv7l/ruby_rubocop-1.26.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.26.1_i686/ruby_rubocop-1.26.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.26.1_x86_64/ruby_rubocop-1.26.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c81b0e5bee7f31d632c5e5a6159331eef36a839aa56d3cd98217161ea1ba1b6e',
     armv7l: 'c81b0e5bee7f31d632c5e5a6159331eef36a839aa56d3cd98217161ea1ba1b6e',
       i686: '61e75cfeaa580f4f78e94dfbee12186331b412721244cfc0d7660bd9338040d9',
     x86_64: '66c9134d10ee390f53449edf863cdc1a58be3af8ed8fda6571aa4228244d45a3'
  })

  no_fhs

  depends_on 'libyaml'
  depends_on 'ruby'
  depends_on 'xdg_base'

  @xdg_config_home = ENV['XDG_CONFIG_HOME']
  @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.build
    system 'bundle install'
    system 'rake build'
  end

  def self.install
    system "gem install --build=#{CREW_DEST_DIR} pkg/rubocop-#{version}.gem"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/rubocup"
    system "curl -Ls https://github.com/satmandu/chromebrew/raw/rubocop_yaml/.rubocop.yml > #{CREW_DEST_PREFIX}/.config/rubocup/config.yml"
    # Uncomment after merge
    # system "curl -Ls https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml > #{CREW_DEST_PREFIX}/.config/rubocup/config.yml"
  end

  def self.postinstall
    # system 'gem install -N rubocop --conservative'
    puts "Installing Chromebrew rubocop config file at #{@xdg_config_home}/rubocop/config.yml".lightblue
    puts 'This can be overridden by a ~/.rubocop.yml'.lightblue
    FileUtils.mkdir_p "#{@xdg_config_home}/rubocop"
    system "curl -Ls https://github.com/satmandu/chromebrew/raw/rubocop_yaml/.rubocop.yml > #{@xdg_config_home}/rubocop/config.yml"
    # Uncomment after merge
    # system "curl -Ls https://github.com/skycocker/chromebrew/raw/master/.rubocop.yml > #{@xdg_config_home}/rubocop/config.yml"
  end

  def self.remove
    # system 'gem uninstall -x rubocop'
    FileUtils.rm_f "#{@xdg_config_home}/rubocop/config.yml"
  end
end
