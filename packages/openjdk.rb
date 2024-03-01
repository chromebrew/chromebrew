require 'package'
Dir["#{CREW_PACKAGES_PATH}/openjdk*.rb"].each do |openjdk_file|
  next unless openjdk_file =~ /openjdk(\d+).rb/

  openjdk_name = File.basename(openjdk_file, '.rb')
  require_relative openjdk_name
end

class Openjdk < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  key = 1
  versions = []
  @openjdk_versions = []
  Dir["#{CREW_PACKAGES_PATH}/openjdk*.rb"].each do |openjdk_file|
    next unless openjdk_file =~ /openjdk(\d+).rb/

    openjdk_name = File.basename(openjdk_file, '.rb')
    openjdk_ver = Object.const_get(openjdk_name.capitalize).version.to_s.gsub(/-(\d+)/, '')
    @openjdk_versions.push [key, openjdk_name, openjdk_ver]
    key += 1
  end
  @openjdk_versions.each do |openjdk_ver|
    versions.push openjdk_ver[2]
  end
  versions.sort!
  version "#{versions.first}-#{versions.last}"
  license 'GPL-2'
  compatibility 'all'

  is_fake

  def self.preflight
    if ARGV.include?('install')
      puts "\n  Select version:"
      @openjdk_versions.each do |openjdk_ver|
        option = "  #{openjdk_ver[0]} = Openjdk #{openjdk_ver[2]}"
        if File.file? "#{CREW_META_PATH}/#{openjdk_ver[1]}.filelist"
          puts option.lightgreen
        else
          puts option
        end
      end
      puts '  0 = Cancel'

      while (version = $stdin.gets.chomp.downcase.to_i)
        version = 0 if version.negative? || version > @openjdk_versions.length
        key = version - 1
        case version
        when @openjdk_versions[key][0]
          if File.file? "#{CREW_META_PATH}/#{@openjdk_versions[key][1]}.filelist"
            abort "Package #{@openjdk_versions[key][1]} already installed.".lightgreen
          else
            depends_on @openjdk_versions[key][1]
          end
          break
        when 0
          abort
        end
      end
    end
  end
end
