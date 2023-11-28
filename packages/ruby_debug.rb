require 'package'

class Ruby_debug < Package
  description 'Debugging functionality for Ruby. This is completely rewritten debug.rb which was contained by the ancient Ruby versions.'
  homepage 'https://github.com/ruby/debug'
  version '1.7.1-ruby-3.2'
  license 'BSD-2 Clause'
  compatibility 'all'
  source_url 'SKIP'

  no_fhs
  no_compile_needed

  depends_on 'libyaml'
  depends_on 'ruby'

  def self.postinstall
    @gem_name = name.sub('ruby_', '')
    system "gem uninstall -Dx --force --abort-on-dependent #{@gem_name}", exception: false
    system "gem install -N #{@gem_name}", exception: false
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
      system "gem uninstall -Dx --force --abort-on-dependent #{gem}", exception: false
    end
  end
end
