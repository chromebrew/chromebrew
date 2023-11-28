require 'package'

class Ruby_concurrent_ruby < Package
  description 'Modern concurrency tools for Ruby. Inspired by Erlang, Clojure, Scala, Haskell, F#, C#, Java, and classic concurrency patterns.'
  homepage 'https://github.com/ruby-concurrency/concurrent-ruby'
  version '1.1.10-ruby-3.2'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_concurrent_ruby/1.1.10-ruby-3.2_armv7l/ruby_concurrent_ruby-1.1.10-ruby-3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_concurrent_ruby/1.1.10-ruby-3.2_armv7l/ruby_concurrent_ruby-1.1.10-ruby-3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_concurrent_ruby/1.1.10-ruby-3.2_i686/ruby_concurrent_ruby-1.1.10-ruby-3.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_concurrent_ruby/1.1.10-ruby-3.2_x86_64/ruby_concurrent_ruby-1.1.10-ruby-3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'eb94a449d442287df52a6afa4c079dd50700c33c398b602973dbb4d77eb574a5',
     armv7l: 'eb94a449d442287df52a6afa4c079dd50700c33c398b602973dbb4d77eb574a5',
       i686: 'ee38c3838f51036de486fca4bf0dc3de7c9a997f7a754d3585befdcee26a76db',
     x86_64: '168941807c0f574570bb53f55818e40e2297b51175442611dcd13010c7f88935'
  })

  no_fhs
  no_compile_needed

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
    system "gem install -N #{@gem_name}", exception: false
  end

  def self.remove
    @gem_name = name.sub('ruby_', '').sub('_', '-')
    @gems_deps = `gem dependency ^#{@gem_name}\$ | awk '{print \$1}'`.chomp
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
