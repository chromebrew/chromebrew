require 'package'

class Ruby_debug < Package
  description 'Debugging functionality for Ruby. This is completely rewritten debug.rb which was contained by the ancient Ruby versions.'
  homepage 'https://github.com/ruby/debug'
  version '1.6.2-1'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_debug/1.6.2_armv7l/ruby_debug-1.6.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_debug/1.6.2_armv7l/ruby_debug-1.6.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_debug/1.6.2_i686/ruby_debug-1.6.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_debug/1.6.2_x86_64/ruby_debug-1.6.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2bdb5f3152576c078f7375bf83cf87c19a620b91c80e6363d127e5aa68ec790c',
     armv7l: '2bdb5f3152576c078f7375bf83cf87c19a620b91c80e6363d127e5aa68ec790c',
       i686: '0046afda40659300d9237be3c45ea444f43c1ccadfbc82e787d4528fb55d98c3',
     x86_64: '449811904d7d9b2969504f5930d3347a4e1590bda94dea9b43d5856935a7a93e'
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
    @gem_name = name.sub('ruby_', '')
    system "gem uninstall -Dx --force --abort-on-dependent #{@gem_name}", exception: false
    system "gem install -N #{@gem_name}", exception: false
  end

  def self.remove
    @gem_name = name.sub('ruby_', '')
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
