require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev'
  @_ver = '3.0.4'
  version @_ver
  license 'BSD-3'
  compatibility 'all'

  source_url({
    aarch64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-arm-release.zip",
     armv7l: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-arm-release.zip",
       i686: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-ia32-release.zip",
     x86_64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-x64-release.zip"
  })
  source_sha256({
    aarch64: '36aebf7bf6d43574dc3f66872e1926e184dd2ef8641212240e57ab895403a967',
     armv7l: '36aebf7bf6d43574dc3f66872e1926e184dd2ef8641212240e57ab895403a967',
       i686: '206b978e824608710e6af3e3301269397ffdec46235fe1d602063b9a30560bde',
     x86_64: 'fed758732d742df884d39770756eb9bd9fdb24665c24c96502a09e03a745fca5'
  })

  no_compile_needed

  def self.install
    dart_prefix = File.join(CREW_LIB_PREFIX, 'dart')

    FileUtils.mkdir_p [CREW_DEST_LIB_PREFIX, File.join(CREW_DEST_PREFIX, 'bin')]
    FileUtils.cp_r '.', File.join(CREW_DEST_DIR, dart_prefix)

    FileUtils.ln_s File.join(dart_prefix, 'bin/dart'), File.join(CREW_DEST_PREFIX, 'bin/dart')
  end
end
