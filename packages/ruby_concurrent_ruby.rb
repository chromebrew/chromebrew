require 'package'

class Ruby_concurrent_ruby < Package
  description 'Modern concurrency tools for Ruby. Inspired by Erlang, Clojure, Scala, Haskell, F#, C#, Java, and classic concurrency patterns.'
  homepage 'https://github.com/ruby-concurrency/concurrent-ruby'
  version '1.1.10'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_concurrent_ruby/1.1.10_armv7l/ruby_concurrent_ruby-1.1.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_concurrent_ruby/1.1.10_armv7l/ruby_concurrent_ruby-1.1.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_concurrent_ruby/1.1.10_i686/ruby_concurrent_ruby-1.1.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_concurrent_ruby/1.1.10_x86_64/ruby_concurrent_ruby-1.1.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '77ce10258eadf962da6da2e99e4646eceb68d4ead5e423640cf0f26dbbfac74e',
     armv7l: '77ce10258eadf962da6da2e99e4646eceb68d4ead5e423640cf0f26dbbfac74e',
       i686: 'f699799facdd54b2618a36f92a3f5a4423fe474a545b2e63d535bf5ae16672d9',
     x86_64: 'aa8c2a94be76cad7e060216efe3a8b4433822e8b7a6567807801565f78f5e69a'
  })

  no_fhs

  depends_on 'libyaml'
  depends_on 'ruby'
  # depends_on 'xdg_base'

  # @xdg_config_home = ENV.fetch('XDG_CONFIG_HOME', nil)
  # @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.build; end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
  end

  def self.postinstall
    @gem_name = name.sub('ruby_', '').sub('_', '-')
    system "gem uninstall -Dx --force --abort-on-dependent #{@gem_name}", exception: false
    system "gem install -N #{@gem_name} --conservative", exception: false
  end

  def self.remove
    @gem_name = name.sub('ruby_', '').sub('_', '-')
    @gems_deps = `gem dependency ^#{@gem_name}\$`.scan(/^([^\s]+?)/).flatten
    # Delete the first line and convert to an array.
    @gems = @gems_deps.split("\n").drop(1).append(@gem_name)
    # bundler never gets uninstalled, though gem dependency lists it for
    # every package, so delete it from the list.
    @gems.delete('bundler')
    @gems.each do |gem|
      system "gem uninstall -Dx --force --abort-on-dependent #{gem}", exception: false
    end
  end
end
