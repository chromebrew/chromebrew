require 'package'
require 'uri'

class Jdk8 < Package
  description 'The Oracle JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java'
  @_ver = '8u341'
  version @_ver
  license 'Oracle-BCLA-JavaSE'
  compatibility 'all'

  @jdk_arch = {
    armv7l: 'arm32-vfp-hflt',
      i686: 'i586',
    x86_64: 'x64'
  }

  @jdk_description = {
    aarch64: 'ARM 32 Hard Float ABI',
     armv7l: 'ARM 32 Hard Float ABI',
       i686: 'x86 Compressed Archive',
     x86_64: 'x64 Compressed Archive'
  }

  source_url({
    aarch64: File.join('file://', HOME, 'Downloads', "jdk-#{@_ver}-linux-#{@jdk_arch[:armv7l]}.tar.gz"),
     armv7l: File.join('file://', HOME, 'Downloads', "jdk-#{@_ver}-linux-#{@jdk_arch[:armv7l]}.tar.gz"),
       i686: File.join('file://', HOME, 'Downloads', "jdk-#{@_ver}-linux-#{@jdk_arch[:i686]}.tar.gz"),
     x86_64: File.join('file://', HOME, 'Downloads', "jdk-#{@_ver}-linux-#{@jdk_arch[:x86_64]}.tar.gz")
  })

  source_sha256({
    aarch64: '6dec09bd213bf97bcab99e54881af85f3911e771f8843470fe384520c0249c33',
     armv7l: '6dec09bd213bf97bcab99e54881af85f3911e771f8843470fe384520c0249c33',
       i686: '6beb8997121c771b9d69742f2be583f566736e517d8afa5d91b371c729e515da',
     x86_64: 'c98e57cfc6ac9947d9aa9a31c5878d52e2bf764f8d90f20eec08f3c3fcaee0e7'
  })

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

    return if File.exist?( URI( get_source_url(ARCH.to_sym) ).path )

    # check if we should prompt user to the archive page or download page based on #{@_ver}
    # download page only contains latest version while archive page only contains older versions

    # get latest available version
    latest_jdk_page  = 'https://www.oracle.com/java/technologies/downloads/#java8'
    is_latest_jdk    = `curl -LSs '#{latest_jdk_page}'`.include?(version)
    jdk_download_url = is_latest_jdk ? latest_jdk_page : 'https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html#JDK'

    abort <<~EOT.orange

      Oracle now requires an account to download the JDK.

      You must login at https://login.oracle.com/mysso/signon.jsp and then visit:
      #{jdk_download_url}

      Download "jdk-#{@_ver}-linux-#{@jdk_arch[ARCH.to_sym]}.tar.gz" (#{@jdk_description[ARCH.to_sym]}) to Chrome OS download folder to continue.
    EOT
  end

  def self.install
    jdk_dir = File.join(CREW_DEST_PREFIX, 'share', name)
    FileUtils.mkdir_p [jdk_dir, File.join(CREW_DEST_PREFIX, 'bin'), CREW_DEST_MAN_PREFIX]

    FileUtils.rm_f ['src.zip', 'javafx-src.zip']
    FileUtils.cp_r '*', jdk_dir

    Dir[File.join(jdk_dir, 'bin', '*')].each do |path|
      filename = File.basename(path)
      symlink  = File.join(CREW_DEST_PREFIX, 'bin', filename)

      FileUtils.ln_s path.sub(CREW_DEST_PREFIX, CREW_PREFIX), symlink
    end

    FileUtils.mv Dir[File.join(jdk_dir, 'man', '*')], CREW_DEST_MAN_PREFIX
  end

  def self.postinstall
    # remove jdk archive after installed
    FileUtils.rm_f URI( get_source_url(ARCH.to_sym) ).path
  end
end
