require 'package'

class Hello_world_chromebrew < Package
  description 'Chromebrew Package Build Test (for use in PR Actions)'
  homepage 'https://github.com/chromebrew/chromebrew'
  version '1.1'
  license 'MIT'       # Package license (eg. GPL-3, MIT, etc.)
  compatibility 'all' # Package architecture compatibility (eg. aarch64, armv7l, i686, x86_64 or all)
  source_url 'https://github.com/chromebrew/chromebrew/raw/master/tools/hello_world_chromebrew.c'
  source_sha256 'ff3632aba26639630ff8c1d91ebc168e185c2cb4fda8c856e61f33d53215aac3'
  binary_compression 'tar.zst'

  # These are needed to successfully build and check for dependencies.
  binary_sha256({
    aarch64: '827f9794864aa76f4c99fd31f989077f1fa65771386f73db30a7681842f8736d',
     armv7l: '827f9794864aa76f4c99fd31f989077f1fa65771386f73db30a7681842f8736d',
       i686: 'ff0942c505b04982fed187bcda123adead37b3ac2dcfd7e2f0543ca179e81df6',
     x86_64: '3081f1f25950c91f75db41095b644a2783987a3a7ef2832fc2b85bf138bb006f'
  })

  # Register dependencies (use the following line as a basis)
  #
  # Runtime dependencies:
  # depends_on '*' # R
  # Build dependencies:
  # depends_on '*' => :build
  #

  # Function to perform patch operations prior to build from source.
  def self.patch
    system "sed -i 's/Hello Chromebrew/Hello, Chromebrew/' hello_world_chromebrew.c"
  end

  # Function to perform pre-build operations prior to build from source.
  def self.prebuild; end

  # Function to perform build from source.
  def self.build
    system 'gcc -o hello hello_world_chromebrew.c'
  end

  # Function to perform check from source build.
  # This is executed only during `crew build`.
  def self.check
    system './hello'
  end

  # Function to perform install from source build.
  def self.install
    FileUtils.install 'hello', "#{CREW_DEST_PREFIX}/bin/hello_chromebrew", mode: 0o755
  end

  # Function to perform post-install for both source build and binary distribution
  def self.postinstall
    system "#{CREW_PREFIX}/bin/hello_chromebrew"
  end
end
