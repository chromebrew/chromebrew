require 'package'
require 'uri'

class Jdk17 < Package
  description 'The Oracle JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java'
  @_ver = '17.0.4.1'
  version @_ver
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'

  @jdk_arch = {
     armv7l: 'arm32-vfp-hflt',
       i686: 'i586',
     x86_64: 'x64'
  }

  source_url File.join('file://', HOME, 'Downloads', "jdk-#{@_ver}_linux-x64_bin.tar.gz")
  source_sha256 '2ac20cd72aa09c6577438e5ab5fd67e2dab606c724a84cfd289feecf6c22a1cf'

  no_compile_needed
  no_patchelf

  def self.preflight
    jdk_exec = File.join(CREW_PREFIX, 'bin', 'java')

    if File.exist?(jdk_exec)
      jdk_ver_str   = `#{jdk_exec} -version 2>&1`
      jdk_ver       = jdk_ver_str[/version "(.+?)"/, 1]
      jdk_major_ver = jdk_ver.match?(/^1.8/) ? '8' : jdk_ver.partition('.')[0]

      is_openjdk   = jdk_ver_str.include?('openjdk')
      pkg_branding = is_openjdk ? 'OpenJDK' : 'Oracle JDK'
      pkg_prefix   = is_openjdk ? 'openjdk' : 'jdk'

      abort <<~EOT.yellow unless jdk_major_ver == name.delete_prefix('jdk') && !is_openjdk

        #{pkg_branding} #{jdk_ver} installed.

        Run "crew remove #{pkg_prefix}#{jdk_major_ver}; crew install #{name}" to install this version of JDK
      EOT
    end

    return if File.exist?( URI(source_url).path )

    abort <<~EOT.orange

      Oracle now requires an account to download the JDK.

      You must login at https://login.oracle.com/mysso/signon.jsp and then visit:
      https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html

      Download "jdk-#{@_ver}_linux-x64_bin.tar.gz" (Linux x64 Compressed Archive) to Chrome OS download folder to continue.
    EOT
  end

  def self.install
    jdk_dir = File.join(CREW_DEST_PREFIX, 'share', name)
    FileUtils.mkdir_p [jdk_dir, File.join(CREW_DEST_PREFIX, 'bin'), CREW_DEST_MAN_PREFIX]

    FileUtils.rm_f 'lib/src.zip'
    FileUtils.cp_r '*', jdk_dir

    Dir[File.join(jdk_dir, 'bin', '*')].each do |path|
      filename = File.basename(path)
      symlink  = File.join(CREW_DEST_PREFIX, 'bin', filename)

      FileUtils.ln_s path.sub(CREW_DEST_PREFIX, CREW_PREFIX), symlink
    end

    FileUtils.rm Dir[File.join(jdk_dir, 'man/man1/k{init,list}.1')] # conflicts with krb5 package
    FileUtils.mv Dir[File.join(jdk_dir, 'man', '*')], CREW_DEST_MAN_PREFIX
  end

  def self.postinstall
    # remove jdk archive after installed
    FileUtils.rm_f URI(source_url).path
  end
end