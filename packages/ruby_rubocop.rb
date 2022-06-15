# Adapted from Arch Linux ruby-rubocop PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ruby-rubocop

require 'package'

class Ruby_rubocop < Package
  description 'A Ruby static code analyzer and formatter'
  homepage 'https://rubocop.org'
  version '1.26.1'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/rubocop/rubocop.git'
  # git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.26.1_armv7l/ruby_rubocop-1.26.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.26.1_armv7l/ruby_rubocop-1.26.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.26.1_i686/ruby_rubocop-1.26.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.26.1_x86_64/ruby_rubocop-1.26.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '751d173e446bf5e478b5cf75d0d2bcf3ca67e8a0fbb602667c4e3d224e938c5c',
     armv7l: '751d173e446bf5e478b5cf75d0d2bcf3ca67e8a0fbb602667c4e3d224e938c5c',
       i686: '3ba763b890c2bb0a39cd07567bc248b7dc4b12242537e817ef1650b4fb2ce6bc',
     x86_64: '59942e42753e15dafe07c9e522fa0e01483e5e2ca66b7c54a347bef8e58d4b8c'
  })

  no_fhs

  depends_on 'libyaml'
  depends_on 'ruby'
  depends_on 'xdg_base'

  @xdg_config_home = ENV['XDG_CONFIG_HOME']
  @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.build
    # system 'bundle install'
    # system 'rake build'
  end

  def self.install
    # system "gem install --build=#{CREW_DEST_DIR} pkg/rubocop-#{version}.gem"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/rubocop"
    downloader 'https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml', 'SKIP', "#{CREW_DEST_PREFIX}/.config/rubocop/config.yml"
  end

  def self.postinstall
    @gem_name = name.sub('ruby_', '')
    system "gem install -N #{@gem_name} --conservative"

    puts "Installing Chromebrew rubocop config file at #{@xdg_config_home}/rubocop/config.yml".lightblue
    puts 'This can be overridden by a ~/.rubocop.yml'.lightblue
    FileUtils.mkdir_p "#{@xdg_config_home}/rubocop"
    downloader 'https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml', 'SKIP', "#{@xdg_config_home}/rubocop/config.yml"
  end

  def self.remove
    @gem_name = name.sub('ruby_', '')
    @gems_deps = `gem dependency ^#{@gem_name}\$ | awk '{print \$1}'`.chomp
    # Delete the first line and convert to an array.
    @gems = @gems_deps.split("\n").drop(1).append(@gem_name)
    # bundler never gets uninstalled, though gem dependency lists it for
    # every package, so delete it from the list.
    @gems.delete('bundler')
    @gems.each do |gem|
      system "gem uninstall -Dx --force --abort-on-dependent #{gem} || true"
    end

    FileUtils.rm_f "#{@xdg_config_home}/rubocop/config.yml"
  end
end
