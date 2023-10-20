# Add fixups to be run during crew update here.

# remove deprecated directory
FileUtils.rm_rf "#{HOME}/.cache/crewcache/manifest"

# Fix missing $PATH not added in install.sh
if !system("grep -q '$PATH' #{CREW_PREFIX}/etc/env.d/path") || Gem::Version.new(CREW_VERSION.to_s) < Gem::Version.new('1.36.4')
  puts 'Fixing path env.d file...'.orange
  puts "Please run 'source ~/.bashrc'".lightblue
  File.write "#{CREW_PREFIX}/etc/env.d/path", <<~ENVD_PATH_EOF
    ## Inserted by Chromebrew version #{CREW_VERSION}
    PATH=#{CREW_PREFIX}/bin:#{CREW_PREFIX}/sbin:#{CREW_PREFIX}/share/musl/bin:$PATH
  ENVD_PATH_EOF
end
