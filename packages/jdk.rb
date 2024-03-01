require 'package'

class Jdk < Package
  description 'The Oracle JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'all'

  # full version number extracted from jdk*.rb recipes
  @avail_jdk_ver = Dir["#{CREW_PACKAGES_PATH}/jdk?*.rb"].map do |pkg_file|
    jdk_majver = pkg_file[/jdk(\d+).rb/, 1].to_i
    pkg        = Package.load_package(pkg_file)

    [jdk_majver, pkg.version]
  end.sort_by do |(jdk_majver, _)|
    jdk_majver
  end.to_h

  version "#{@avail_jdk_ver.values[0]}-#{@avail_jdk_ver.values[-1]}"

  is_fake

  def self.preflight
    if ARGV.include?('install')
      jdk_exec = File.join(CREW_PREFIX, 'bin', 'java')

      if File.exist?(jdk_exec)
        jdk_ver_str   = `#{jdk_exec} -version 2>&1`
        jdk_ver       = jdk_ver_str[/version "(.+?)"/, 1]
        jdk_major_ver = jdk_ver.match?(/^1.8/) ? '8' : jdk_ver.partition('.')[0]

        is_openjdk   = jdk_ver_str.include?('openjdk')
        pkg_branding = is_openjdk ? 'OpenJDK' : 'Oracle JDK'
        pkg_prefix   = is_openjdk ? 'openjdk' : 'jdk'

        abort <<~EOT.yellow

          #{pkg_branding} #{jdk_ver} installed.

          Run "crew remove #{pkg_prefix}#{jdk_major_ver}; crew install #{name}" to install another version of JDK
        EOT
      end

      options = @avail_jdk_ver.map {|majver, ver| { value: "jdk#{majver}", description: "Oracle JDK #{ver}" } }
      depends_on Selector.new(options).show_prompt
    end
  end
end
