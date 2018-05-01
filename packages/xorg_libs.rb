require 'package'

class Xorg_libs < Package
  description 'A collection of xorg libraries.'
  homepage 'https://www.x.org'
  version '0.1.0'
  source_url 'https://dl.bintray.com/chromebrew2/chromebrew2/dummy-package.tar.gz'
  source_sha256 'baeb7289a5979d19e99c44830c7d685d345177a6845f0ae9ca1527fe58408dbd'
  
  depends_on 'libxcb'
  depends_on 'fontconfig'
  depends_on 'libbsd'
  
  depends_on 'font_util'
  depends_on 'filecmd'
    
  # Download all related xorg library source code (global variables xorg_libsource_name and sha256sum_source)
  $xorg_lib_source_name = Array[];
  $sha256sum_source = Array[];
  
  $xorg_lib_source_name.push("xtrans-1.3.5.tar.gz")
  $sha256sum_source.push("b7a577c1b6c75030145e53b4793db9c88f9359ac49e7d771d4385d21b3e5945d")
    
  $xorg_lib_source_name.push("libX11-1.6.5.tar.gz")
  $sha256sum_source.push("3abce972ba62620611fab5b404dafb852da3da54e7c287831c30863011d28fb3")
  
  $xorg_lib_source_name.push("libXext-1.3.3.tar.gz")
  $sha256sum_source.push("eb0b88050491fef4716da4b06a4d92b4fc9e76f880d6310b2157df604342cfe5")
  
  $xorg_lib_source_name.push("libFS-1.0.7.tar.gz")
  $sha256sum_source.push("91bf1c5ce4115b7dbf4e314fdbee54052708e8f7b6a2ec6e82c309bcbe40ef3d")
  
  $xorg_lib_source_name.push("libICE-1.0.9.tar.gz")
  $sha256sum_source.push("7812a824a66dd654c830d21982749b3b563d9c2dfe0b88b203cefc14a891edc0")
  
  
  
  $xorg_lib_source_name.push("libSM-1.2.2.tar.gz")
  $sha256sum_source.push("14bb7c669ce2b8ff712fbdbf48120e3742a77edcd5e025d6b3325ed30cf120f4")
  
  $xorg_lib_source_name.push("libXScrnSaver-1.2.2.tar.gz")
  $sha256sum_source.push("e12ba814d44f7b58534c0d8521e2d4574f7bf2787da405de4341c3b9f4cc8d96")
  
  $xorg_lib_source_name.push("libXt-1.1.5.tar.gz")
  $sha256sum_source.push("b59bee38a9935565fa49dc1bfe84cb30173e2e07e1dcdf801430d4b54eb0caa3")
  
  $xorg_lib_source_name.push("libXmu-1.1.2.tar.gz")
  $sha256sum_source.push("e5fd4bacef068f9509b8226017205040e38d3fba8d2de55037200e7176c13dba")
  
  $xorg_lib_source_name.push("libXpm-3.5.12.tar.gz")
  $sha256sum_source.push("2523acc780eac01db5163267b36f5b94374bfb0de26fc0b5a7bee76649fd8501")
  
  
  
  $xorg_lib_source_name.push("libXaw-1.0.13.tar.gz")
  $sha256sum_source.push("7e74ac3e5f67def549722ff0333d6e6276b8becd9d89615cda011e71238ab694")
  
  $xorg_lib_source_name.push("libXfixes-5.0.3.tar.gz")
  $sha256sum_source.push("9ab6c13590658501ce4bd965a8a5d32ba4d8b3bb39a5a5bc9901edffc5666570")
  
  $xorg_lib_source_name.push("libXcomposite-0.4.4.tar.gz")
  $sha256sum_source.push("83c04649819c6f52cda1b0ce8bcdcc48ad8618428ad803fb07f20b802f1bdad1")
  
  $xorg_lib_source_name.push("libXrender-0.9.10.tar.gz")
  $sha256sum_source.push("770527cce42500790433df84ec3521e8bf095dfe5079454a92236494ab296adf")
  
  $xorg_lib_source_name.push("libXcursor-1.1.15.tar.gz")
  $sha256sum_source.push("449befea2b11dde58ba3323b2c1ec30550013bd84d80501eb56d0048e62251a1")
  
  
  
  $xorg_lib_source_name.push("libXdamage-1.1.4.tar.gz")
  $sha256sum_source.push("4bb3e9d917f5f593df2277d452926ee6ad96de7b7cd1017cbcf4579fe5d3442b")
  
  $xorg_lib_source_name.push("libfontenc-1.1.3.tar.gz")
  $sha256sum_source.push("6fba26760ca8d5045f2b52ddf641c12cedc19ee30939c6478162b7db8b6220fb")
  
  $xorg_lib_source_name.push("libXfont2-2.0.3.tar.gz")
  $sha256sum_source.push("a4b761a37528353a2b83dba364d7c1fd6aef2d554a1a019815f24f7f8866890e")
  
  $xorg_lib_source_name.push("libXft-2.3.2.tar.gz")
  $sha256sum_source.push("26cdddcc70b187833cbe9dc54df1864ba4c03a7175b2ca9276de9f05dce74507")
  
  $xorg_lib_source_name.push("libXi-1.7.9.tar.gz")
  $sha256sum_source.push("463cc5370191404bc0f8a450fdbf6d9159efbbf274e5e0f427a60191fed9cf4b")
  
  
  
  $xorg_lib_source_name.push("libXinerama-1.1.3.tar.gz")
  $sha256sum_source.push("0ba243222ae5aba4c6a3d7a394c32c8b69220a6872dbb00b7abae8753aca9a44")
  
  $xorg_lib_source_name.push("libXrandr-1.5.1.tar.gz")
  $sha256sum_source.push("2baa7fb3eca78fe7e11a09b373ba898b717f7eeba4a4bfd68187e04b4789b0d3")
  
  $xorg_lib_source_name.push("libXres-1.2.0.tar.gz")
  $sha256sum_source.push("5b62feee09f276d74054787df030fceb41034de84174abec6d81c591145e043a")
  
  $xorg_lib_source_name.push("libXtst-1.2.3.tar.gz")
  $sha256sum_source.push("a0c83acce02d4923018c744662cb28eb0dbbc33b4adc027726879ccf68fbc2c2")
  
  $xorg_lib_source_name.push("libXv-1.0.11.tar.gz")
  $sha256sum_source.push("c4112532889b210e21cf05f46f0f2f8354ff7e1b58061e12d7a76c95c0d47bb1")
  
  
  
  $xorg_lib_source_name.push("libXvMC-1.0.10.tar.gz")
  $sha256sum_source.push("d8306f71c798d10409bb181b747c2644e1d60c05773c742c12304ab5aa5c8436")
  
  $xorg_lib_source_name.push("libXxf86dga-1.1.4.tar.gz")
  $sha256sum_source.push("e6361620a15ceba666901ca8423e8be0c6ed0271a7088742009160349173766b")
  
  $xorg_lib_source_name.push("libXxf86vm-1.1.4.tar.gz")
  $sha256sum_source.push("5108553c378a25688dcb57dca383664c36e293d60b1505815f67980ba9318a99")
  
  $xorg_lib_source_name.push("libdmx-1.1.3.tar.gz")
  $sha256sum_source.push("c4b24d7e13e5a67ead7a18f0b4cc9b7b5363c9d04cd01b83b5122ff92b3b4996")
  
  $xorg_lib_source_name.push("libpciaccess-0.14.tar.gz")
  $sha256sum_source.push("8d86e64893917be3dfb1c5e837888d1275399c818783474002203d751312b03c")
  
  
  
  $xorg_lib_source_name.push("libxkbfile-1.0.9.tar.gz")
  $sha256sum_source.push("95df50570f38e720fb79976f603761ae6eff761613eb56f258c3cb6bab4fd5e3")
  
  $xorg_lib_source_name.push("libxshmfence-1.3.tar.gz")
  $sha256sum_source.push("7eb3d46ad91bab444f121d475b11b39273142d090f7e9ac43e6a87f4ff5f902c")
  
  
  def self.preinstall
    system "mkdir -pv xorg_lib"
    
    ############################################################
    puts "Start downloading xorg library source code".lightblue
    ############################################################
    for index in 0 ... $xorg_lib_source_name.size
      filename = "#{$xorg_lib_source_name[index]}"
      sha256sum = "#{$sha256sum_source[index]}"
      url = "https://www.x.org/archive/individual/lib/#{filename}"
      
      folder_name = "#{$xorg_lib_source_name[index]}"
      folder_name.slice! ".tar.gz"  # remove .tar.gz
      
      if File.exist?(filename) && Digest::SHA256.hexdigest( File.read("./#{filename}") ) == sha256sum
        puts "#{filename} exists and perform unpacking".yellow
      else
        puts "Downloading #{filename}".yellow
        system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url, '-o', filename)
        abort 'Checksum mismatch. :/ Try again.'.lightred unless
          Digest::SHA256.hexdigest( File.read("./#{filename}") ) == sha256sum
        puts "#{filename} downloaded".lightgreen
      end
      
      system "tar", "xf", "#{filename}", "-C", "xorg_lib"
      puts "#{filename} unpacked".lightgreen
    end
    
    ############################################################
    puts "All xorg library source code are unpacked!".lightgreen
    ############################################################
  
  end
  
  
  def self.build
    Dir.chdir("xorg_lib") do
    ############################################################
    puts "Start compiling xorg library from source".lightblue
    ############################################################
      for index in 0 ... $xorg_lib_source_name.size
        folder_name = "#{$xorg_lib_source_name[index]}"
        folder_name.slice! ".tar.gz"  # remove .tar.gz
  
        puts "Configuring #{folder_name} ...".lightblue
        Dir.chdir(folder_name) do
         
          if folder_name.include? "libICE"
            system "./configure",
                   "--prefix=#{CREW_PREFIX}",
                   "--libdir=#{CREW_LIB_PREFIX}",
                   "ICE_LIBS=-lpthread"     # This fixes a change in glibc which breaks pulseaudio at runt time
          end
          
          if folder_name.include? "libXfont2"
            system "./configure",
                   "--prefix=#{CREW_PREFIX}",
                   "--libdir=#{CREW_LIB_PREFIX}",
                   "--disable-static",
                   "--enable-shared",
                   "--disable-devel-docs"
          end
          
          if folder_name.include? "libX11"
            system "./configure",
                   "--prefix=#{CREW_PREFIX}",
                   "--libdir=#{CREW_LIB_PREFIX}",
                   "--disable-static",
                   "--enable-shared",
                   "--enable-loadable-i18n"
          end
            
          if folder_name.include? "libXt-"
            system "./configure",
                   "--prefix=#{CREW_PREFIX}",
                   "--libdir=#{CREW_LIB_PREFIX}",
                   "--disable-static",
                   "--enable-shared",
                   "--with-appdefaultdir=#{CREW_PREFIX}/etc/X11/app-defaults"
          else
            system "./configure",
                   "--prefix=#{CREW_PREFIX}",
                   "--libdir=#{CREW_LIB_PREFIX}",
                   "--disable-static",
                   "--enable-shared"
          end
        
          system "make"
          system "make install"  # This step is only
          system "find #{CREW_LIB_PREFIX} -type f -name *.la -delete"
        end
        
      end
    end
  
  end

  def self.install
    Dir.chdir("xorg_lib") do
    ############################################################
    puts "Start packaging xorg library".lightblue
    ############################################################
    
    # Build package
      for index in 0 ... $xorg_lib_source_name.size
        folder_name = "#{$xorg_lib_source_name[index]}"
        folder_name.slice! ".tar.gz"  # remove .tar.gz
  
        puts "Packaging #{folder_name} ...".lightblue
  
        Dir.chdir(folder_name) do
          system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
        end
      end
      
    # Remove installed package on system
      for index in 0 ... $xorg_lib_source_name.size
        folder_name = "#{$xorg_lib_source_name[index]}"
        folder_name.slice! ".tar.gz"  # remove .tar.gz
  
        puts "Removing installed library #{folder_name} ...".lightblue
  
        Dir.chdir(folder_name) do
          system "make uninstall" # remove installed library
        end
      end
      
    end
  end
  
end